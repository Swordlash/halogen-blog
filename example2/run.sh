#!/bin/sh
set -ex

EXEC=example2

cabal build $EXEC

IN=$(cabal exec which $EXEC)".jsexe/all.js"
OUT="./example2/assets/index.js"

cp $IN $OUT

npx webpack build --config ./example2/assets/webpack.config.js
npx http-server dist/