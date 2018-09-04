{-# LANGUAGE TupleSections #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

import Data.Ratio
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.UpdatePointer
import XMonad.Actions.SpawnOn (shellPromptHere, manageSpawn)
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.ResizeScreen
import XMonad.Layout.LayoutModifier
import qualified XMonad.Layout.HintedTile as HT
import XMonad.Layout.Gaps
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.ToggleLayouts (ToggleLayout(ToggleLayout))
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.EZConfig
import XMonad.Util.NamedWindows
import XMonad.Util.Paste
import XMonad.Util.Run

import qualified XMonad.StackSet as W

data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
    urgencyHook LibNotifyUrgencyHook w = do
        name     <- getName w
        Just idx <- W.findTag w <$> gets windowset

        safeSpawn "notify-send" [show name, "workspace " ++ idx]

data Center = Center deriving (Show, Read, Eq, Typeable)

instance Transformer Center Window where
    transform Center x k = k (centered x) (const x)


centered = resizeHorizontal 300 . resizeHorizontalRight 300
gapSize = 10
taffySize = 25
sideGaps = False

allGaps = (U, taffySize + if sideGaps then gapSize else 0) :
            if sideGaps then map (,gapSize) (enumFrom D)
                        else []

baseLayout =
    let
        tall = ResizableTall 1 (3/100) (1/2) []
    in
        tall ||| Mirror tall
-- ||| spiral (6/7)

layout =
         smartBorders
       . mkToggle (FULL ?? Center ?? EOT)
       $ baseLayout

main = xmonad
     $ withUrgencyHook LibNotifyUrgencyHook
     $ ewmh
     $ defaultConfig {
             terminal    = "urxvtc"
           , modMask     = mod4Mask
           --, logHook     = updatePointer (1 / 2, 1 / 2) (0, 0)
           , layoutHook  = layout
           , startupHook = setWMName "LG3D"
           , manageHook  = manageSpawn <+> manageDocks
           , normalBorderColor = "#222"
           , focusedBorderColor = "#97C178"
     }
     `additionalKeysP` myKeys

myXPConfig =
    defaultXPConfig {
      font        = "xft:Inconsolata:size=14",
      height      = 25,
      borderColor = "#000000"
    }

toggleGaps = sendMessage ToggleGaps
toggleFull = sendMessage (Toggle FULL)
toggleCenter = sendMessage (Toggle Center)
toggleMaximized = toggleGaps >> toggleFull

myKeys = [
    ("M-p", shellPromptHere myXPConfig)
  , ("M-a", focusUrgent)
  , ("M-d", toggleWS)
  , ("M-r", toggleFull)
  , ("M-c", toggleCenter)
  -- , ("M-f", toggleMaximized)
  -- , ("M-r", toggleFull)
  , ("M-v", sendKey shiftMask xK_Insert)
  ]
