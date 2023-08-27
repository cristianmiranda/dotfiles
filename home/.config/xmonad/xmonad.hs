--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import Data.Monoid
import System.Exit
import Control.Exception (catch, SomeException)
import Control.Monad (filterM, liftM)
import Data.Maybe (listToMaybe, isJust, fromJust, fromMaybe)
import Data.List (isInfixOf)

-- Actions
import XMonad.Actions.CycleWS
import qualified XMonad.Actions.FlexibleManipulate as Flex
import XMonad.Actions.Navigation2D
import XMonad.Actions.Submap
import XMonad.Actions.SwapWorkspaces
import XMonad.Actions.WindowGo (raise, runOrRaise)
import XMonad.Actions.UpdatePointer

-- Layout modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Spacing

-- Hooks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ServerMode

-- Utilities
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.WindowPropertiesRE

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth = 2

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#556064"
myFocusedBorderColor = "#1793D1"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--

toggleFloat w = windows (\s -> if M.member w (W.floating s)
                            then W.sink w s
                            else (W.float w (W.RationalRect (1/3) (1/4) (1/2) (4/5)) s))

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [
        ((modm, xK_Return), spawn $ XMonad.terminal conf)

        -- close focused window
        , ((modm, xK_q), kill)

        -- Rotate through the available layout algorithms
        , ((modm .|. controlMask, xK_space ), sendMessage NextLayout)

        --  Reset the layouts on the current workspace to default
        --  , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

        -- Resize viewed windows to the correct size
        , ((modm .|. shiftMask, xK_r), refresh)

        -- Move focus to the master window
        , ((modm, xK_m), windows W.focusMaster)

        -- Swap the focused window and the master window
        , ((modm .|. shiftMask, xK_m), windows W.swapMaster)

        -- Shrink the master area
        , ((modm.|. shiftMask, xK_minus), sendMessage Shrink)

        -- Expand the master area
        , ((modm.|. shiftMask, xK_plus), sendMessage Expand)

        -- Push window back into tiling
        , ((modm .|. shiftMask, xK_space), withFocused toggleFloat)

        -- Increment the number of windows in the master area
        , ((modm, xK_comma), sendMessage (IncMasterN 1))

        -- Deincrement the number of windows in the master area
        , ((modm, xK_period), sendMessage (IncMasterN (-1)))

        -- Toggle workspaces
        , ((modm, xK_Tab), toggleWS)

        -- Move window to next workspace
        , ((modm .|. controlMask, xK_Right), shiftNextScreen >> nextScreen)

        -- Move window to previous workspace
        , ((modm .|. controlMask, xK_Left),  shiftPrevScreen >> prevScreen)

        -- Move focus to next workspace
        , ((modm, xK_minus), nextScreen)

        -- Move focus to previous workspace
        -- , ((modm, xK_Left), prevScreen)

        -- Guake style terminal (tdrop)
        , ((modm, xK_masculine), spawn "tdrop --name tdrop -ma -w -8 -x 2 -y 34 -h 80% -s general alacritty")

        -- Quit xmonad
        , ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess))

        -- Restart xmonad
        , ((modm .|. shiftMask, xK_x), spawn "xmonad --recompile; xmonad --restart")
    ]

    ++

    [
        ((modm, xK_c), raise (className =? "Code"))
        ,((modm, xK_d), raise (className =? "Discord"))
        ,((modm, xK_e), raise (className =? "firefoxdeveloperedition"))
        ,((modm, xK_f), raise (className =? "firefox"))
        ,((modm, xK_i), raise (className =? "jetbrains-idea"))
        ,((modm, xK_j), raise (className =? "Jitsi Meet"))
        ,((modm, xK_m), raise (className =? "thunderbird"))
        ,((modm, xK_n), raise (className =? "notion-app"))
        ,((modm, xK_s), raise (className ~? "Spotify"))
        ,((modm, xK_t), raise (className =? "TelegramDesktop"))
        ,((modm, xK_w), raise (className ~? "whatsapp.*"))
    ]

    ++

    -- Swap current workspace with another one
    -- mod-ctrl-[1-9]
    --
    [
        ((modm .|. controlMask, k), windows $ swapWithCurrent i)
            | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    ]

    ++
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-alt-[1..9], Move client to workspace N
    --
    [
        ((m .|. modm, k), windows $ f i)
            | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, mod1Mask)]
    ]

    ++
    --
    -- mod-shift-m + [1..9], Move client to workspace N
    --
    [
        ((modm .|. shiftMask, xK_m), submap . M.fromList $
       [ ((0, k), windows $ f i)
            | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
       ])
    ]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [
        -- Allows resizing of floating windows from any corner and moves it by dragging from the center
        ((modm, button1), (\w -> focus w >> Flex.mouseWindow Flex.discrete w))
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--

myLayout = avoidStruts (tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

myLayoutHook = spacingWithEdge 3 $ myLayout

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "Polybar"          --> doIgnore
    , title     =? "tdrop"            --> doFloat
    , className =? "i3FloatingWindow" --> doFloat
    , resource  =? "desktop_window"   --> doIgnore
    ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--

------------------------------------------------------------------------
-- External commands
--
-- ghc --make -dynamic xmonadctl.hs
--
myCommands :: [(String, X ())]
myCommands =
        [ ("decrease-master-size"      , sendMessage Shrink                               )
        , ("increase-master-size"      , sendMessage Expand                               )
        , ("decrease-master-count"     , sendMessage $ IncMasterN (-1)                    )
        , ("increase-master-count"     , sendMessage $ IncMasterN ( 1)                    )
        , ("focus-prev"                , windows W.focusUp                                )
        , ("focus-next"                , windows W.focusDown                              )
        , ("focus-master"              , windows W.focusMaster                            )
        , ("swap-with-prev"            , windows W.swapUp                                 )
        , ("swap-with-next"            , windows W.swapDown                               )
        , ("swap-with-master"          , windows W.swapMaster                             )
        , ("kill-window"               , kill                                             )
        , ("quit"                      , io $ exitWith ExitSuccess                        )
        , ("restart"                   , spawn "xmonad --recompile; xmonad --restart"     )
        ]

-----------------------------------------------------------------------
-- Custom server mode

myServerModeEventHook = serverModeEventHookCmd' $ return myCommands'
myCommands' = ("list-commands", listMyServerCmds) : myCommands ++ wscs -- ++ sccs -- ++ spcs
    where
        wscs = [((m ++ s), windows $f s) | s <- myWorkspaces
               , (f, m) <- [(W.view, "focus-workspace-"), (W.shift, "send-to-workspace-")] ]

--        sccs = [((m ++ show sc), screenWorkspace (fromIntegral sc) >>= flip whenJust (windows . f))
--               | sc <- [0..myMaxScreenCount], (f, m) <- [(W.view, "focus-screen-"), (W.shift, "send-to-screen-")]]

--        spcs = [("toggle-" ++ sp, namedScratchpadAction myScratchpads sp)
--               | sp <- (flip map) (myScratchpads) (\(NS x _ _ _) -> x) ]

listMyServerCmds :: X ()
listMyServerCmds = spawn ("echo '" ++ asmc ++ "' | xmessage -file -")
    where asmc = concat $ "Available commands:" : map (\(x, _)-> "    " ++ x) myCommands'

myEventHook = mempty <+> myServerModeEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
-- myLogHook = return ()
myLogHook = dynamicLog >> updatePointer (0.5, 0.5) (0, 0)

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
        spawnOnce "~/.config/startup/startup-once.sh"
        spawn "~/.config/startup/startup-always.sh"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--

--
-- CopyQ. Ignore copyq events so that they don't steal focus.
--

netWmUserTime :: String
netWmUserTime = "_NET_WM_USER_TIME"

ewmhWithIgnore :: XConfig l -> XConfig l
ewmhWithIgnore x = x
    { handleEventHook = \ev -> do
        userTimeAtom <- getAtom netWmUserTime
        ignoreCopyQ <- shouldIgnoreCopyQEvent ev
        if ignoreCopyQ
           then return (All False) -- Ignore the event
           else (handleEventHook x ev) <+> (ewmhIgnore userTimeAtom ev)
    }

shouldIgnoreCopyQEvent :: Event -> X Bool
shouldIgnoreCopyQEvent ev = do
    let win = ev_window ev
    wmClass <- liftIO $ catch (runProcessWithInput "xprop" ["-id", show win, "WM_CLASS"] "") handler
    return $ "copyq" `isInfixOf` wmClass
  where
    handler :: SomeException -> IO String
    handler _ = return ""

ewmhIgnore :: Atom -> Event -> X All
ewmhIgnore userTimeAtom ev =
    if ev `isClientMessageEvent` userTimeAtom
       then return (All False)
       else return (All True)  -- Simply propagate the event unchanged.

isClientMessageEvent :: Event -> Atom -> Bool
isClientMessageEvent ClientMessageEvent{ ev_message_type = mt } targetAtom = mt == targetAtom
isClientMessageEvent _ _ = False

--
-- Main
--

myNavigation2DConfig = def { defaultTiledNavigation = hybridOf lineNavigation sideNavigation
                           , floatNavigation        = centerNavigation
                           , screenNavigation       = lineNavigation
                           , layoutNavigation       = []
                           , unmappedWindowRect     = []
                           }

main = xmonad
        $ docks
        $ withNavigation2DConfig myNavigation2DConfig
        $ additionalNav2DKeys (xK_Up, xK_Left, xK_Down, xK_Right)
                                    [(mod4Mask,               windowGo  ),
                                     (mod4Mask .|. shiftMask, windowSwap)]
                                    False
        $ ewmhWithIgnore
        $ ewmh
        $ defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayoutHook,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
