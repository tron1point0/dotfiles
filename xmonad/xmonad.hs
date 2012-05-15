import XMonad
import XMonad.Actions.DynamicWorkspaces
import XMonad.Layout.NoBorders
import XMonad.Layout.LayoutHints
import XMonad.Layout.DwmStyle
import XMonad.Layout.MouseResizableTile
import XMonad.Layout.IM
import XMonad.Layout.Grid
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Prompt
import XMonad.Prompt.XMonad
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeysP)
import System.IO
import Data.Ratio

main = do
  spawn "~/.cabal/bin/xmobar ~/.xmonad/xmobar.hs"
  xmonad $ defaultConfig {
    terminal = "urxvt",
    workspaces = ["1:alfa","2:bravo","3:charlie","4:delta"] ++ map (show) [5..9],
    layoutHook =
        avoidStruts
      . layoutHints
      . (dwmStyle shrinkText defaultTheme)
      . smartBorders $
        mouseResizableTile |||
        (withIM (1%7) (Title "Chat") Grid) |||
        Tall 1 0.05 (1%5) |||
        Full,
    manageHook = manageDocks <+> manageHook defaultConfig,
    logHook = dynamicLogString xmobarPP {
            ppCurrent = xmobarColor "yellow" "" . wrap "[" "]",
            ppHidden = xmobarColor "tan" "" . wrap "|" "|",
            ppHiddenNoWindows = xmobarColor "grey" "" . wrap " " " ",
            ppUrgent = xmobarColor "red" "" . wrap "!" "!",
            ppSep = " ❙ ",
            ppTitle = xmobarColor "lightgreen" "" . shorten 50
        } >>= xmonadPropLog
} `additionalKeysP` [
    ("M-<F2>", spawn "dmenu_run"),
    ("M-p", xmonadPrompt defaultXPConfig),
    ("M-r", renameWorkspace defaultXPConfig),
    ("<XF86AudioRaiseVolume>", spawn "amixer sset Master 1+"),
    ("<XF86AudioMute>", spawn "amixer sset Master toggle"),
    ("<XF86AudioLowerVolume>", spawn "amixer sset Master 1-")
    ]
