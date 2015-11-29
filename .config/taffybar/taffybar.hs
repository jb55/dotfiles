{-# LANGUAGE OverloadedStrings #-}

import System.Taffybar

import System.Taffybar.FreedesktopNotifications
import System.Taffybar.MPRIS
import System.Taffybar.NetMonitor
import System.Taffybar.SimpleClock
import System.Taffybar.Systray
import System.Taffybar.TaffyPager
import System.Taffybar.Weather

import Data.Maybe (fromMaybe)

import System.Taffybar.Widgets.PollingBar
import System.Taffybar.Widgets.PollingGraph

import System.Information.Memory
import System.Information.Network
import System.Information.CPU

memCallback = do
  mi <- parseMeminfo
  return [memoryUsedRatio mi]

cpuCallback = do
  (userLoad, systemLoad, totalLoad) <- cpuLoad
  return [totalLoad, systemLoad]

netCallback = do
  minfo <- getNetInfo "eno1"
  return (maybe [0,0] (map fromInteger) minfo)

weatherConf :: WeatherConfig
weatherConf = (defaultWeatherConfig "CYVR") {
    weatherTemplate = "$tempC$ °C"
  }

main = do
  let memCfg = defaultGraphConfig { graphDataColors = [(1, 0, 0, 1)]
                                  , graphLabel = Just "mem"
                                  }
      cpuCfg = defaultGraphConfig { graphDataColors = [ (0, 1, 0, 1)
                                                      , (1, 0, 1, 0.5)
                                                      ]
                                  , graphLabel = Just "cpu"
                                  }
      netCfg = defaultGraphConfig { graphDataColors = [ (0, 1, 0, 1)
                                                      , (1, 0, 1, 0.5)
                                                      ]
                                  , graphLabel = Just "net"
                                  }
  let clock = textClockNew Nothing "<span fgcolor='orange'>%a %b %_d %l:%M %P</span>" 1
      pager = taffyPagerNew defaultPagerConfig
      note = notifyAreaNew defaultNotificationConfig
      wea = weatherNew weatherConf 10
      mpris = mprisNew defaultMPRISConfig
      mem = pollingGraphNew memCfg 1 memCallback
      cpu = pollingGraphNew cpuCfg 0.5 cpuCallback
      net = netMonitorNewWith 1.5 "eno1" 0 "▼ $inMB$MBps ▲ $outKB$KBps"
      tray = systrayNew
  defaultTaffybar defaultTaffybarConfig { startWidgets = [ pager, note ]
                                        , endWidgets = reverse [ mem, cpu, mpris, net, wea, clock, tray ]
                                        }
