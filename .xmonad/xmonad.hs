import XMonad
import XMonad.Config.Gnome
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig
import XMonad.Prompt.Shell
import XMonad.Prompt

main = xmonad $
    gnomeConfig {
            terminal    = "term"
          , layoutHook  = smartBorders (layoutHook gnomeConfig)
    }
    `additionalKeysP` myKeys

myKeys = [
    ("M-x", shellPrompt defaultXPConfig)
  ]
