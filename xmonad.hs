import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import Graphics.X11.Xinerama
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig

import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8

main = do
     dbus <- D.connectSession
     getWellKnownName dbus
     let conf = (myConfig dbus)
     xmonad conf

myConfig dbus = ewmh $ gnomeConfig
         { modMask = mod4Mask
         , logHook = dynamicLogWithPP (prettyPrinter dbus)
         --, startupHook = spawn "xcompmgr"
         , manageHook = composeAll
           [ (manageHook gnomeConfig)
           , (stringProperty "WM_NAME") =? "Run Application" --> doFloat
           ]
         , focusedBorderColor = "#888"
         , normalBorderColor = "#000"
         }
         `additionalKeysP` 
                 [ ("M-S-q", spawn "gnome-session-quit")
                 , ("M-p", gnomeRun)
                 ]

prettyPrinter :: D.Client -> PP
prettyPrinter dbus = defaultPP
    { ppOutput   = dbusOutput dbus
    , ppTitle    = pangoSanitize
    , ppCurrent  = pangoColor "green" . wrap "[" "]" . pangoSanitize
    , ppVisible  = pangoColor "yellow" . wrap "(" ")" . pangoSanitize
    , ppHidden   = pangoSanitize
    , ppUrgent   = pangoColor "red" . pangoSanitize
    , ppLayout   = pangoSanitize
    , ppSep      = " : "
    }

getWellKnownName :: D.Client -> IO ()
getWellKnownName dbus = do
  D.requestName dbus (D.busName_ "org.xmonad.Log")
                [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]
  return ()
  
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
    let signal = (D.signal (D.objectPath_ "/org/xmonad/Log") (D.interfaceName_ "org.xmonad.Log") (D.memberName_ "Update")) {
            D.signalBody = [D.toVariant ("<b>" ++ (UTF8.decodeString str) ++ "</b>")]
        }
    D.emit dbus signal

pangoColor :: String -> String -> String
pangoColor fg = wrap left right
  where
    left  = "<span foreground=\"" ++ fg ++ "\">"
    right = "</span>"

pangoSanitize :: String -> String
pangoSanitize = foldr sanitize ""
  where
    sanitize '>'  xs = "&gt;" ++ xs
    sanitize '<'  xs = "&lt;" ++ xs
    sanitize '\"' xs = "&quot;" ++ xs
    sanitize '&'  xs = "&amp;" ++ xs
    sanitize x    xs = x:xs
