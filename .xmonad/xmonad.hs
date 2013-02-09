import XMonad
import XMonad.Config.Gnome
import XMonad.Actions.CycleWS
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig
import XMonad.Prompt.Shell
import XMonad.Prompt

main = xmonad $
    gnomeConfig {
            terminal    = "term"
          , layoutHook  = smartBorders (layoutHook gnomeConfig)
          , modMask     = mod4Mask
    }
    `additionalKeysP` myKeys

myKeys = [
    ("M-x", shellPrompt defaultXPConfig)
  , ("M-w", toggleWS)
  , ("M-n", nextWS)
  , ("M-p", prevWS)
  ]
