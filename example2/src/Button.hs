{-# LANGUAGE OverloadedStrings, LambdaCase #-}
module Button (button) where

import Halogen hiding (Initialize, Finalize, State)
import Halogen.HTML qualified as HH
import Halogen.HTML.Properties qualified as HP
import Halogen.HTML.Properties.ARIA qualified as HPA
import Halogen.HTML.Events qualified as HE
import Web.DOM.Internal.Types (HTMLElement)
import Control.Monad.State
import Data.Foreign
import Data.Foldable
import Data.Text qualified as T


newtype MDCRipple = MDCRipple (Foreign MDCRipple)

foreign import javascript unsafe "init_ripple" initRipple :: HTMLElement -> IO MDCRipple
foreign import javascript unsafe "destroy_ripple" destroyRipple :: MDCRipple -> IO ()

data Action = Initialize | Finalize | Click
data State = State { ripple :: Maybe MDCRipple, counter :: Int }

button :: Component q i o IO
button = mkComponent $ ComponentSpec
  { initialState = const $ State Nothing 0
  , render
  , eval = mkEval $ defaultEval { handleAction, initialize = Just Initialize, finalize = Just Finalize }
  }

  where
    ref = RefLabel "mdc-button"

    text 0 = "Click me!"
    text n = T.pack $ "Clicked " <> show n <> " times"

    render State{counter} = 
      HH.div [HP.class_ (HH.ClassName "mdc-touch-target-wrapper")]
        $ pure
        $ HH.button
          [ HP.classes 
            [ HH.ClassName "mdc-button", HH.ClassName "mdc-button--outlined", HH.ClassName "mdc-button--icon-leading" ]
            , HE.onClick (const Click)
            , HP.ref ref
          ]
          [ HH.span [HP.class_ (HH.ClassName "mdc-button__ripple")] []
          , HH.span [HP.class_ (HH.ClassName "mdc-button__touch")] []
          , HH.i [HP.classes [HH.ClassName "material-icons", HH.ClassName "mdc-button__icon"], HPA.hidden "true"] [HH.text "add"]
          , HH.span [HP.class_ (HH.ClassName "mdc-button__label")] [HH.text $ text counter]
          ]


    handleAction Click = modify' $ \s -> s { counter = counter s + 1 }
    handleAction Finalize = gets ripple >>= traverse_ (liftIO . destroyRipple)
    handleAction Initialize =
      getHTMLElementRef ref >>= \case
        Just el -> do
          r <- liftIO $ initRipple el 
          modify' (\s -> s { ripple = Just r })
        Nothing -> error "Could not find button element"