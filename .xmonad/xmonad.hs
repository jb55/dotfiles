{-# LANGUAGE TupleSections #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

import Data.Ratio
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn (shellPromptHere, manageSpawn)
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.Gaps
import XMonad.Layout.Grid
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Maximize
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.ResizeScreen
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ToggleLayouts (ToggleLayout(ToggleLayout))
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.EZConfig
import XMonad.Util.NamedWindows
import XMonad.Util.Paste
import XMonad.Util.Run
import qualified XMonad.Layout.HintedTile as HT

import qualified XMonad.StackSet as W

data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
    urgencyHook LibNotifyUrgencyHook w = do
        name     <- getName w
        Just idx <- W.findTag w <$> gets windowset

        safeSpawn "notify-send" [show name, "workspace " ++ idx]

data Center = Center deriving (Show, Read, Eq, Typeable)
data Maximized = Maximized deriving (Show, Read, Eq, Typeable)
data Gapz = Gapz deriving (Show, Read, Eq, Typeable)
data TabbedFull = TabbedFull deriving (Show, Read, Eq, Typeable)

orig (ModifiedLayout _   o) = o
modi (ModifiedLayout mod _) = mod

instance Transformer Center Window where
    transform Center x k = k (centered x) (orig . orig)

instance Transformer Gapz Window where
    transform Gapz x k = k (smartSpacingWithEdge gapSize x) orig

instance Transformer TabbedFull Window where
    transform TabbedFull x k = k (tabs ||| Full) (const x)

centered = resizeHorizontal 300 . resizeHorizontalRight 300

gapSize = 5
sideGaps = False

ourFont = "xft:terminus:size=12"
tabs = tabbed shrinkText tabTheme

tabTheme =
    defaultTheme {
        fontName = ourFont
      , inactiveBorderColor = "#282C34"
      , activeBorderColor = "#282C34"
      , activeColor = "#323742"
      , inactiveColor = "#282C34"
    }

allGaps = (U, if sideGaps then gapSize else 0) :
            if sideGaps then map (,gapSize) (enumFrom D)
                        else []

baseLayout =
    let
        tall = ResizableTall 1 (3/100) (1/2) []
    in
        Mirror tall -- ||| otherstuff

layout = smartBorders
       . mkToggle (Center ?? EOT)
       . mkToggle (TabbedFull ?? EOT)
       . mkToggle (Gapz ?? EOT)
       . mkToggle (MIRROR ?? EOT)
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
           , focusedBorderColor = "#BE5046"
     }
     `additionalKeysP` myKeys

myXPConfig =
    defaultXPConfig {
      font        = ourFont,
      height      = 20,
      borderColor = "#000000"
    }

nWindows :: X Int
nWindows = fmap go get
  where
    go = length . W.integrate'
                . W.stack
                . W.workspace
                . W.current
                . windowset

toggleGaps = sendMessage (Toggle Gapz)
toggleFull = sendMessage (Toggle TabbedFull)
toggleMirror = sendMessage (Toggle MIRROR)
toggleCenter = sendMessage (Toggle Center)

myKeys = [
    ("M-p", shellPromptHere myXPConfig)
  , ("M-a", focusUrgent)
  , ("M-d", toggleWS)
  , ("M-f", toggleFull)
  , ("M-c", toggleCenter)
  , ("M-m", toggleMirror)
  , ("M-g", toggleGaps)
  -- , ("M-r", toggleFull)
  , ("M-v", sendKey shiftMask xK_Insert)
  ]
