{-# LANGUAGE TupleSections #-}

--import XMonad.Hooks.ICCCMFocus
import Data.Ratio
import System.Taffybar.Hooks.PagerHints (pagerHints)
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Layout.Gaps
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.EZConfig
import XMonad.Util.Paste

gapSize = 10
taffySize = 25

allGaps = (U, taffySize + gapSize) : (map (,gapSize) (enumFrom D))

baseLayout = Tall 1 (3/100) (1/2)
         ||| Full

layout = gaps allGaps
       . smartBorders
       . mkToggle (single FULL)
       $ baseLayout

main = xmonad $
    ewmh $
    pagerHints $
    defaultConfig {
            terminal    = "urxvt"
          , modMask     = mod4Mask
          , logHook     = updatePointer (Relative 0.5 0.5)
          , layoutHook  = layout
          , startupHook = setWMName "LG3D"
          , manageHook  = manageDocks
          , normalBorderColor = "black"
          , focusedBorderColor = "#ff7a00"
    }
    `additionalKeysP` myKeys


myKeys = [
    ("M-p", shellPrompt defaultXPConfig)
  , ("M-d", toggleWS)
  , ("M-g", sendMessage $ ToggleGaps)
  , ("M-e", sendMessage $ Toggle FULL)
  , ("M-v", sendKey shiftMask xK_Insert)
  ]
