--------------------------------------------------------------------------------
module Main (main) where

--------------------------------------------------------------------------------
import XMonad
import XMonad.Actions.DynamicWorkspaces
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Prompt
import XMonad.Util.EZConfig

--------------------------------------------------------------------------------
main :: IO ()
main = do
    putStrLn "XMonad starting..."
    xmonad cfg
  where
    cfg = desktopConfig

            { layoutHook = avoidStruts (Tall 1 (3/100) (1/2))

              -- FIXME: should this be in X.C.Desktop?
            , handleEventHook = docksEventHook
            }

            `additionalKeysP`

            [ ("M-S-w", addWorkspacePrompt xpcfg)
            ]

    xpcfg = def { font = "xft:monospace:size=9"
                }
