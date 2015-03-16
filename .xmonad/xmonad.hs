import XMonad
import XMonad.Actions.CycleWS
import XMonad.Util.EZConfig
import XMonad.Prompt.Shell
import XMonad.Prompt
import XMonad.Hooks.SetWMName
--import XMonad.Hooks.ICCCMFocus

main = xmonad $
    defaultConfig {
--          terminal    = "term"
            modMask     = mod4Mask
          , startupHook = setWMName "LG3D"
    }
    `additionalKeysP` myKeys

myKeys = [
    ("M-x", shellPrompt defaultXPConfig)
  , ("M-d", toggleWS)
  , ("M-n", nextWS)
  , ("M-p", prevWS)
  ]
