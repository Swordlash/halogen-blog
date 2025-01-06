{-# LANGUAGE MultilineStrings #-}
module Main where

import Data.IORef
import GHC.JS.Foreign.Callback
import GHC.JS.Prim

foreign import javascript unsafe "install_handler"
  install_handler :: Callback (IO JSVal) -> IO ()

main :: IO ()
main = do
  ref <- newIORef 0

  let incRef = toJSInt <$> atomicModifyIORef' ref (\x -> (x + 1, x + 1))

  syncCallback' incRef >>= install_handler