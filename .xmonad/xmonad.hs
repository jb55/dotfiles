{-# LANGUAGE TupleSections #-}

--import XMonad.Hooks.ICCCMFocus
import Data.Ratio
import System.Taffybar.Hooks.PagerHints (pagerHints)
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.Gaps
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.ToggleLayouts (ToggleLayout(ToggleLayout))
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.EZConfig
import XMonad.Util.Paste
import XMonad.Hooks.UrgencyHook (focusUrgent)

gapSize = 10
taffySize = 25
sideGaps = False

allGaps = (U, taffySize + if sideGaps then gapSize else 0) :
            if sideGaps then (map (,gapSize) (enumFrom D))
                        else []

baseLayout = Tall 1 (3/100) (1/2)
         ||| Full

layout = gaps allGaps
       -- . noBorders
       . smartBorders
       -- . mkToggle (single FULL)
       $ baseLayout

-- myManageHook = composeAll
--              [
--                isFullscreen --> toggleMaximized
--              , manageDocks
--              ]

main = xmonad $
    ewmh $
    pagerHints $
    defaultConfig {
            terminal    = "urxvt"
          , modMask     = mod4Mask
          , layoutHook  = layout
          , startupHook = setWMName "LG3D"
          , manageHook  = manageDocks
          , normalBorderColor = "#222"
          , focusedBorderColor = "#555"
    }
    `additionalKeysP` myKeys


toggleGaps = sendMessage ToggleGaps
toggleFull = sendMessage (Toggle FULL)
toggleMaximized = toggleGaps >> toggleFull

myKeys = [
    ("M-p", shellPrompt defaultXPConfig)
  , ("M-a", focusUrgent)
  , ("M-d", toggleWS)
  , ("M-r", sendMessage NextLayout)
  , ("M-f", toggleMaximized)
  -- , ("M-r", toggleFull)
  , ("M-v", sendKey shiftMask xK_Insert)
  ]
