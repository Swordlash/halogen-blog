module Main where

import Data.IORef
import GHC.JS.Foreign.Callback
import GHC.JS.Prim

foreign import javascript unsafe 
  " ((f) => { \
    \var node = document.createElement(\"button\"); \
    \node.textContent = \"Click me!\"; \
    \node.onclick = () => { \
    \  node.textContent = `Clicked ${f()} times`; \
    \}; \
    \document.body.appendChild(node); \
  \})"
  install_handler :: Callback (IO JSVal) -> IO ()

main :: IO ()
main = do
  ref <- newIORef 0
  let incRef = toJSInt <$> (modifyIORef' ref (+1) *> readIORef ref)

  syncCallback' incRef >>= install_handler