--------------------------------------------------------------------------------
module Main (main) where

--------------------------------------------------------------------------------
import XMonad
import XMonad.Actions.DynamicWorkspaces
import XMonad.Config.Desktop
import XMonad.Prompt
import XMonad.Util.EZConfig

--------------------------------------------------------------------------------
main :: IO ()
main = do
    putStrLn "XMonad starting..."
    xmonad cfg
  where
    cfg = desktopConfig `additionalKeysP`
            [ ("M-S-w", addWorkspacePrompt xpcfg)
            ]

    xpcfg = def { font = "xft:monospace:size=9"
                }
