import XMonad
import XMonad.Config.Gnome
import XMonad.Layout.NoBorders
main = xmonad
    gnomeConfig {
            terminal    = "term"
          , layoutHook  = smartBorders (layoutHook gnomeConfig)
    }
