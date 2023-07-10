#!/usr/bin/wpexec

--[[

  WP Virtual HSP/HFP mic

  This is a wireplumber standalone script or plugin that creates a virtual
  mic for every bluetooth device that supports both HSP/HFP and A2DP profiles.

  This virtual mic is automatically connected to the actual mic when it exists
  and the profile is automatically changed to HSP/HFP when the virtual mic is
  connected to a client.

  Thus, you only need to configure the virtual mic as a source in your applications,
  and when these applications connect to the virtual mic the profile is automatically
  changed.


  There are three moving cogs:
    Whenever a BT device that supports both profiles, a virtual node is created
    Whenever the HSP/HFP mic is detected, it's connected to the virtual node
    The BT profile is changed depending on whether or not the virtual node has
    clients
  Wireplumber's bt-profile-switch.lua example was really helpful to learn how to deal
  with its BT API


  Author: Jose Maria Perez Ramos <jose.m.perez.ramos+git gmail>
  License: MIT


  Copyright 2022 Jose Maria Perez Ramos

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

]]

local default_config = {profile_debounce_time_ms = 1000} -- setmetatable unavailable :(
local config = ... or {}
for k, v in pairs(default_config) do
  if type(v) == "number" then
    config[k] = tonumber(config[k]) or v
  elseif type(v) == "boolean" then
    local config_v = config[k]
    if type(config_v) == "boolean" then
    elseif config_v == "true" then
      config[k] = true
    elseif config_v == "false" then
      config[k] = false
    else
      config[k] = v
    end
  end
end

-- BT Device Id to Virtual Source node items
local virtual_sources = {
  -- BT Device Id = {
  --    node = Virtual Source node (keeps the reference alive)
  --    in_port_id = Virtual Source In Port id
  --    out_port_om = Virtual Source Out Port OM (keeps the reference alive)
  -- }
}
-- BT Device Id to debounce timers
local debounce_timers = {
  -- BT Device Id = Profile change debounce timer (keeps the reference)
}

local real_sources = {
  -- BT Device Id = {
  --    node_id = Real Source Node id
  --    port_id = Real Source Out port id
  -- }
}

local links = {
  -- BT Device Id = Link (keeps the reference alive)
}

local function replace_destroy(table, key, value, level)
  -- setmetatable unavailable :(
  level = level or 0
  if level > 10 then return end
  local obj = table[key]
  if type(obj) == "userdata" then
    if obj.request_destroy then
      obj:request_destroy()
    elseif obj.destroy then
      obj:destroy()
    end
  elseif type(obj) == "table" then
    for k in pairs(obj) do
      replace_destroy(obj, k, nil, level + 1)
    end
  end
  table[key] = value
end

local function get_bound_id(object)
  return object and object["bound-id"]
end
local function get_device_id(object)
  return object and object.properties and tonumber(object.properties['device.id'])
end

local function maybe_link(device_id)
  local virtual_source = virtual_sources[device_id] or {}
  local real_source = real_sources[device_id] or {}

  if virtual_source.node and virtual_source.in_port_id and real_source.node_id and real_source.port_id then
    if not links[device_id] then
      local link = Link("link-factory", {
        ["link.input.node"] = get_bound_id(virtual_source.node),
        ["link.input.port"] = virtual_source.in_port_id,
        ["link.output.node"] = real_source.node_id,
        ["link.output.port"] = real_source.port_id,
      })
      links[device_id] = link
      link:activate(Feature.Proxy.BOUND)
      Log.debug(link, "Ready")
    end
  else
    replace_destroy(links, device_id, nil)
  end
end


do
  -- Device profile is changed based on links
  -- There's a debounce timer to avoid too frequent changes
  local function change_profile_in_device_node(device, index)
    local callback = function()
      Log.debug(device, "Execute the change")
      device:set_param("Profile", Pod.Object{"Spa:Pod:Object:Param:Profile", "Profile", index = index})
      replace_destroy(debounce_timers, get_bound_id(device), nil)
      return false
    end

    local timeout = config.profile_debounce_time_ms
    if timeout > 0 then
      replace_destroy(debounce_timers, get_bound_id(device), Core.timeout_add(timeout, callback))
    else
      callback()
    end
  end

  local function generate_change_profile_based_on_links_fun(device, profile_to_index, decreasing)
    -- Keeps a reference to device as upvalue, but with the device removal
    -- the om is removed too (and thus these callbacks)
    return function(om)
      if (virtual_sources[get_bound_id(device)] or {}).out_port_om ~= om then
        -- The active OM is not the one this callback is for, it's going to be
        -- deleted shortly
        return
      end
      local n_objects = om:get_n_objects()
      if n_objects == 0 then
        Log.debug(device, "Schedule change to a2dp")
        change_profile_in_device_node(device, profile_to_index["a2dp-sink"])
      elseif n_objects == 1 and not decreasing then
        Log.debug(device, "Schedule change to HSP/HFP")
        change_profile_in_device_node(device, profile_to_index["headset-head-unit"])
      end
    end
  end

  -- Virtual source node is created for those devices that support
  -- both a2dp and headset profiles
  -- The node is deleted when the device is removed
  bt_devices_om = ObjectManager {
    Interest {
      type = "device",
      Constraint{"media.class", "=", "Audio/Device"},
      Constraint{"device.api", "=", "bluez5"},
    }
  }
  bt_devices_om:connect("object-added", function(_, device)
    local profile_to_index = {}
    for profile in device:iterate_params("EnumProfile") do
      profile = profile:parse()
      profile_to_index[profile.properties.name] = profile.properties.index
      if profile_to_index["a2dp-sink"] and profile_to_index["headset-head-unit"] then
        Log.debug(device, "Creating dummy HSP/HFP node")
        local device_id = get_bound_id(device)
        local device_name = device.properties["device.name"]
        local properties = {
          ["factory.name"] = "support.null-audio-sink",
          ["media.class"] = "Audio/Source/Virtual",
          ["node.name"] = device_name..".virtual_hsphfp_mic",
          ["node.description"] = (device.properties["device.description"] or "").." virtual HSP/HFP mic",
          ["audio.position"] = "MONO",
          ["object.linger"] = false, -- Do not keep node if script terminates
          ["device.id"] = device_id,
        }
        local device_priority = config.device_priority
        device_priority = type(device_priority) == "table" and device_priority[device_name] or device_priority
        if device_priority then
          properties["priority.session"] = tonumber(config.device_priority) or 2011 -- bluez default highest priority is 2010
        end
        local node = Node("adapter", properties)
        local virtual_source = {node = node}
        replace_destroy(virtual_sources, device_id, virtual_source)

        node:connect("ports-changed", function(node)
          -- Even if this triggers after the node destruction has been
          -- requested it does not matter because the globals have been
          -- removed (virtual_sources) or are no longer valid (device)
          Log.debug(device, "Dummy HSP/HFP node ports changed")
          -- Modify link status
          virtual_source.in_port_id = get_bound_id(node:lookup_port{Constraint{"port.direction", "=", "in"}})
          maybe_link(device_id)

          -- Monitor number of links for clients in the virtual node
          local out_port = node:lookup_port{Constraint{"port.direction", "=", "out"}}
          if out_port then
            local om = ObjectManager{
              Interest{
                type = "Link",
                Constraint{"link.output.node", "=", get_bound_id(node)},
                Constraint{"link.output.port", "=", get_bound_id(out_port)},
              }
            }
            virtual_source.out_port_om = om
            om:connect("object-added", generate_change_profile_based_on_links_fun(device, profile_to_index))
            om:connect("object-removed", generate_change_profile_based_on_links_fun(device, profile_to_index, true))
            om:connect("installed", generate_change_profile_based_on_links_fun(device, profile_to_index))
            om:activate()
          else
            virtual_source.out_port_om = nil
            replace_destroy(debounce_timers, device_id, nil)
          end
        end)
        node:activate(Features.ALL)
        break
      end
    end
  end)
  bt_devices_om:connect("object-removed", function(_, device)
    local device_id = get_bound_id(device)
    replace_destroy(virtual_sources, device_id, nil)
    maybe_link(device_id)
    replace_destroy(debounce_timers, device_id, nil)
  end)
  bt_devices_om:activate()
end

do
  -- When both the virtual node and the headset profile node exist,
  -- they are linked together

  local function ports_changed_callback(source)
    local device_id = get_device_id(source)
    local real_source = real_sources[device_id]
    if (real_source or {}).node_id == get_bound_id(source) then -- Protect against race conditions
      real_source.port_id = get_bound_id(source:lookup_port{Constraint{"port.direction", "=", "out"}})
      Log.debug(source, "Real HSP/HFP node ports changed")
      maybe_link(device_id)
    end
  end

  sources_om = ObjectManager {
    Interest {
      type = "node",
      Constraint{"media.class", "=", "Audio/Source"},
    }
  }
  sources_om:connect("object-added", function(_, source)
    local device_id = get_device_id(source)
    if not virtual_sources[device_id] then
      return
    end
    -- A Source was added with its device matching one of
    -- the interesting ones
    -- It's assumed that the device event is always triggered
    -- before this source's
    Log.debug(source, "Virtual source found")
    replace_destroy(real_sources, device_id, {node_id = get_bound_id(source)})
    source:connect("ports-changed", ports_changed_callback)
    ports_changed_callback(source)
  end)
  sources_om:connect("object-removed", function(_, source)
    local device_id = get_device_id(source)
    if (real_source or {}).node_id == get_bound_id(source) then -- Protect against race conditions
      Log.debug(source, "Remove")
      replace_destroy(real_sources, device_id, nil)
      maybe_link(device_id)
    end
  end)
  sources_om:activate()
end
