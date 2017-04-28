import System.Exit
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Fullscreen
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.Shell
import XMonad.Util.EZConfig
import XMonad.Util.Run (hPutStrLn, spawnPipe)

main = do
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
  xmonad
    $ defaultConfig
        { terminal = "xterm"
        , manageHook = myManageHook
          <+> fullscreenManageHook
          <+> manageDocks
          <+> manageHook defaultConfig
        , layoutHook = fullscreenFloat
          $ fullscreenFocus
          $ layoutHints
          $ smartBorders
          $ avoidStruts
          $ layoutHook defaultConfig
        , handleEventHook = fullscreenEventHook <+> docksEventHook
        , logHook = dynamicLogWithPP $ xmobarPP { ppOutput = hPutStrLn xmproc }
        }
    `additionalKeysP` [ ("M-S-q", confirmPrompt myXPConfig "exit"
                        $ io exitSuccess)
                      , ("M-p", shellPrompt myXPConfig)
                      ]
    `additionalKeys` [ ((mod4Mask, xK_q), spawn
                       "xmonad --recompile && xmonad --restart")
                     ]

myXPConfig = defaultXPConfig
  { position = Top
  , promptBorderWidth = 0
  , defaultText = ""
  , alwaysHighlight = True
  , font = "xft:monospace:size=9"
  }

myManageHook =
  composeOne [isFullscreen -?> doFullFloat, isDialog -?> doFloat, transience]
    <+> composeAll
          [ className =? "Pidgin" --> doFloat
          , className =? "XCalc" --> doFloat
          , className =? "mpv" --> doFloat
          ]
