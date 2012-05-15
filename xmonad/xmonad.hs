import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeysP)
import System.IO

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar $XDG_CONFIG_HOME/xmonad/xmobar.hs"
  xmonad $ defaultConfig {
    terminal = "urxvt",
    workspaces = ["1:alfa","2:bravo","3:charlie","4:delta"],
    layoutHook = avoidStruts $ layoutHook defaultConfig,
    manageHook = manageDocks <+> manageHook defaultConfig,
    logHook = dynamicLogWithPP xmobarPP {
        ppOutput = hPutStrLn xmproc,
        ppTitle = xmobarColor "green" "" . shorten 50
    }
} `additionalKeysP` [("M-<F2>", spawn "dmenu_run")]
