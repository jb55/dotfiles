import XMonad
import OSXMonad.Core

main = osxmonad defaultConfig {
           modMask = mod4Mask .|. controlMask
         , keys = osxKeys
       }
