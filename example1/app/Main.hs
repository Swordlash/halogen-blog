module Main where

import Data.IORef
import GHC.JS.Foreign.Callback
import GHC.JS.Prim

foreign import javascript unsafe 
  " ((f) => { \
    \var node = document.createElement(\"button\"); \
    \node.textContent = \"Click me!\"; \
    \node.onclick = function () { \
    \  var result = f(); \
    \  console.log(\"Clicked \" + result + \" times\"); \
    \}; \
    \document.body.appendChild(node); \
  \})"
  install_handler :: Callback (IO JSVal) -> IO ()

main :: IO ()
main = do
  ref <- newIORef 0

  let incRef = toJSInt <$> atomicModifyIORef' ref (\x -> (x + 1, x + 1))

  syncCallback' incRef >>= install_handler