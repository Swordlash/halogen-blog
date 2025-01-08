module Main (main) where

import Button
import Halogen.VDom.Driver (runUI)
import Halogen.IO.Util
import Control.Monad (void)

main :: IO ()
main = awaitBody >>= void . runUI button ()