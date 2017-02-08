--------------------------------------------------------------------------------
module Main (main) where

--------------------------------------------------------------------------------
import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.UrgencyHook

--------------------------------------------------------------------------------
main :: IO ()
main = xmonad cfg
  where
    cfg = withUrgencyHookC StdoutUrgencyHook uhConf desktopConfig
    uhConf = UrgencyConfig Never (Every 1)
