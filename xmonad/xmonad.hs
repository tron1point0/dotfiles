-- Dependencies:
--
-- xmobar installed with cabal and compiled with utf8, xft, iwlib, and alsa
-- support:
--
--     cabal install xmobar --flags="with_utf8 with_xft with_iwlib with_alsa"
--
-- dmenu with the http://tools.suckless.org/dmenu/patches/xft patch
-- Ubuntu & DejaVu Sans fonts

import XMonad
import XMonad.Actions.CycleWS
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
        withIM (1%5) (Title "Chat") Grid |||
        Tall 1 0.05 (3%5) |||
        Full,
    manageHook = manageDocks <+> manageHook defaultConfig,
    logHook = dynamicLogString xmobarPP {
            ppCurrent = xmobarColor "yellow" "#0F0F0F" . wrap "[" "]",
            ppHidden = xmobarColor "tan" "" . wrap "|" "|",
            ppHiddenNoWindows = xmobarColor "grey" "" . wrap " " " ",
            ppUrgent = xmobarColor "red" "" . wrap "!" "!",
            ppSep = " ❙ ",
            ppOrder = \(ws:l:t:_) -> [ws,t],
            ppTitle = xmobarColor "lightgreen" "" . shorten 50
        } >>= xmonadPropLog
} `additionalKeysP` [
    ("M-<F2>", spawn "dmenu_run -fn 'Ubuntu Mono-11'"),
    ("M-x", xmonadPrompt defaultXPConfig),
    ("M-<R>", nextWS),
    ("M-<L>", prevWS),
    ("<XF86AudioRaiseVolume>", spawn "amixer sset Master 1+"),
    ("<XF86AudioMute>", spawn "amixer sset Master toggle"),
    ("<XF86AudioLowerVolume>", spawn "amixer sset Master 1-")
    ]
