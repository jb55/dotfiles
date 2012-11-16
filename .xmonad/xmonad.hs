import XMonad
import OSXMonad.Core

main = osxmonad defaultConfig {
           modMask = mod1Mask
         , keys = osxKeys
       }
