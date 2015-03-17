{-# LANGUAGE TupleSections #-}

import XMonad
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Actions.CycleWS
import XMonad.Actions.UpdatePointer
import XMonad.Util.EZConfig
import XMonad.Prompt.Shell
import XMonad.Prompt
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops (ewmh)
import System.Taffybar.Hooks.PagerHints (pagerHints)
--import XMonad.Hooks.ICCCMFocus

gapSize = 10

allGaps = map (,gapSize) (enumFrom U)

gapSpacing = gaps allGaps $ Tall 1 (2/100) (1/2) ||| Full

layoutSpacing = spacing 10 $ Tall 1 (3/100) (1/2)

main = xmonad $
    ewmh $
    pagerHints $
    defaultConfig {
            terminal    = "urxvt"
          , modMask     = mod4Mask
          , logHook     = updatePointer (Relative 0.5 0.5)
          --, layoutHook  = layoutSpacing
          , startupHook = setWMName "LG3D"
          , manageHook  = manageDocks
          , normalBorderColor = "black"
          , focusedBorderColor = "#555555"
    }
    `additionalKeysP` myKeys


myKeys = [
    ("M-x", shellPrompt defaultXPConfig)
  , ("M-d", toggleWS)
  , ("M-n", nextWS)
  , ("M-p", prevWS)
  , ("M-g", sendMessage $ ToggleGaps)
  , ("M-f", sendMessage $ ToggleGap U)
  ]
