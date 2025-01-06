# Case Study - Porting a PureScript framework to GHC

Any useful browser single-page application needs to react to user input to modify the webpage content and perform I/O like data fetching. Since GHC version 9.8 release, we can instantiate JavaScript-level functions with Haskell closures, allowing us for example to pass Haskell-level actions to DOM event listeners.