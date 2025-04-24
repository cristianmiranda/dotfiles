#!/usr/bin/env bash

###############################################################################
# move-ws ─ Smart workspace mover for i3                                   v1.0
#
# ❖ WHY DOES THIS EXIST?  ─────────────────────────────────────────────────────
# • i3 (4.24 with mouse_warping=output) should warp the pointer when you run
#   `move workspace to output <dir>`.
# • On multi-monitor setups (esp. 4 heads) a long-standing race condition
#   (#3518, fixed partly by PR #4604) can steal focus back to the *old*
#   output before the pointer moves, leaving the cursor behind.
# • We first tried:
#       move workspace … ; focus output …
#   but that double-warps when the initial warp succeeds (felt jerky).
# • Toggling mouse_warping off → move → on again is impossible: the directive
#   is parsed only at config-reload time.
# • Disabling focus_follows_mouse would solve it, but I *want* that behaviour.
#
#   → Solution: leave i3 to do its thing, wait a hair, *verify* it worked;
#               if it didn’t, warp once with xdotool.
#
# ❖ DEPENDENCIES  ──────────────────────────────────────────────────────────────
#   - bash 4+, xdotool, jq, i3-msg (comes with i3)
#
# ❖ HOW IT WORKS  (step-by-step)  ─────────────────────────────────────────────
#   1. Record current pointer coordinates (X0,Y0).
#   2. Send `move workspace to output $dir` to i3.
#   3. Sleep ≈ 80 ms  (enough for i3 and X to process focus & warp).
#   4. Read pointer coords again (X1,Y1).
#      • If they *changed* → i3 warped successfully → exit.
#      • If they’re *identical* → warp manually to the centre of the focused
#        container on the (now) focused output.
#
# ❖ TUNABLES  ─────────────────────────────────────────────────────────────────
#   SLEEP=0.08      # decrease if your box is zippy; increase if glitches re-appear
#
# ❖ SEE ALSO  ─────────────────────────────────────────────────────────────────
#   - i3 bug report: https://github.com/i3/i3/issues/3518
#   - Partial fix PR : https://github.com/i3/i3/pull/4604
###############################################################################

dir="$1"

# 1. remember where the pointer is *now*
read X0 Y0 <<<"$(xdotool getmouselocation --shell | awk -F= '/^[XY]/{printf "%s ",$2}')"

# 2. ask i3 to move the *workspace*               (fast, native)
i3-msg -q "move workspace to output $dir"

# 3. give i3 ~80 ms to do its own warp
sleep 0.08          # tweak if your box is very slow / very fast

# 4. pointer still on the old coordinates? then warp manually
read X1 Y1 <<<"$(xdotool getmouselocation --shell | awk -F= '/^[XY]/{printf "%s ",$2}')"
if (( ${X0} == ${X1} && ${Y0} == ${Y1} )); then
    # centre of the *focused container* on the new output
    eval $(i3-msg -t get_tree \
          | jq -r '.. | select(.focused? == true) | "CX=\(.rect.x + .rect.width/2) CY=\(.rect.y + .rect.height/2)"')
    xdotool mousemove "$CX" "$CY"
fi
