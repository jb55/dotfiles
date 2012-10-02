import XMonad
import OSXMonad.Core

main = osxmonad defaultConfig {
     layoutHook = Tall 1 (3/100) (1/2)
   }
