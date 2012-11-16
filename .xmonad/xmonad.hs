import XMonad
import OSXMonad.Core

main = osxmonad defaultConfig {
           modMask = mod1Mask .|. controlMask
         , keys = osxKeys
       }
