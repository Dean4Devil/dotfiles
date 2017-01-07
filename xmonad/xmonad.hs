import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Util.NamedScratchpad

import XMonad.Util.Run

import qualified XMonad.StackSet as W

import System.Exit
--import System.IO

import qualified Data.Map as M

main :: IO ()
main = do
    panel <- spawnPipe panelCmd
    xmonad $ ewmh desktopConfig
        { terminal        = "st"
        , startupHook     = startupHook desktopConfig
                          <+> comptonHook
                          <+> wallpaperHook
                          <+> xbindkeysHook
                          <+> setWMName "LG3D"
        , manageHook      = manageDocks
                          <+> globalTermHook
        , layoutHook      = avoidStrutsOn [U, D] $ layoutHook desktopConfig
        , logHook         = dynamicLogWithPP $ namedScratchpadFilterOutWorkspacePP (xmobarPP { ppOutput = hPutStrLn panel })
        , handleEventHook = docksEventHook
        , keys            = keyBinds
        , modMask         = mod4Mask
        , focusedBorderColor = "#005577"
        , normalBorderColor = "#444444"
        }
  where wallpaperHook  = spawn "/usr/bin/feh --bg-scale ~/Pictures/Wallpaper/A8rgHLL.jpg"
        comptonHook    = spawn "compton --config ~/.config/compton.conf"
        xbindkeysHook  = spawn "xbindkeys"
        globalTermHook = namedScratchpadManageHook scratchpads

locm :: KeyMask
locm = mod1Mask

keyBinds :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keyBinds conf@XConfig {XMonad.modMask = globm} = M.fromList $
    -- launching and killing programs
    [ ((globm,               xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
    , ((globm,               xK_r     ), spawn "rofi -modi \"run,drun,window,ssh\" -show run -fullscreen -location 0 -lines 19 -bw 0 -font \"MonacoB 16\" -padding 330 -separator-style none -opacity 80") -- %! Launch rofi
    , ((globm .|. shiftMask, xK_c     ), kill) -- %! Close the focused window
    , ((globm,               xK_s     ), spawn "/usr/local/bin/lockscreen") -- %! Lock the screen

    , ((locm,               xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
    , ((locm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default

    , ((locm,               xK_n     ), refresh) -- %! Resize viewed windows to the correct size

    -- move focus up or down the window stack
    , ((locm,               xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
    , ((locm .|. shiftMask, xK_Tab   ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((locm,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
    , ((locm,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((locm,               xK_m     ), windows W.focusMaster) -- %! Move focus to the master window

    -- modifying the window order
    , ((locm,               xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((locm .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
    , ((locm .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

    -- resizing the master/slave ratio
    , ((locm,               xK_h     ), sendMessage Shrink) -- %! Shrink the master area
    , ((locm,               xK_l     ), sendMessage Expand) -- %! Expand the master area

    -- floating layer support
    , ((locm,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

    -- increase or decrease number of windows in the master area
    , ((locm              , xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
    , ((locm              , xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

    , ((globm             , xK_p), namedScratchpadAction scratchpads "scratchpad")
    , ((globm             , xK_o), namedScratchpadAction scratchpads "hamster")
    -- quit, or restart
    , ((globm .|. shiftMask, xK_q     ), io exitSuccess) -- %! Quit xmonad
    , ((globm              , xK_q     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. globm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
    [((m .|. globm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    , (f, m) <- [(W.view, mod2Mask), (W.shift, shiftMask)]]

panelCmd :: String
panelCmd = "/usr/bin/xmobar ~/.xmobarrc"

scratchpads :: NamedScratchpads
scratchpads = [
    NS "scratchpad" "st -n scratchpad" (resource =? "scratchpad")
        (customFloating $ W.RationalRect 0.25 0.017 0.5 0.3),

    NS "hamster" "hamster" (className =? "Hamster")
        (customFloating $ W.RationalRect 0.6 0.7 0.4 0.3)
    ]
