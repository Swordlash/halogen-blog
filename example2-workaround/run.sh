#!/bin/sh
set -ex

EXEC=example2-workaround

cabal build $EXEC

IN=$(cabal exec which $EXEC)".jsexe/all.js"
IN_EXT=$(cabal exec which $EXEC)".jsexe/all.externs.js"
M_EXT="./example2-workaround/src/Button.externs.js"
OUT="./example2-workaround/assets/index.js"

npx google-closure-compiler \
  --language_in UNSTABLE \
  --compilation_level ADVANCED_OPTIMIZATIONS \
  --warning_level QUIET \
  --isolation_mode IIFE \
  --assume_function_wrapper \
  --emit_use_strict \
  --js $IN \
  --js $IN_EXT \
  --js $M_EXT \
  --js_output_file $OUT

echo "Input size: $(du -h $IN | cut -f1)"
echo "Output size: $(du -h $OUT | cut -f1)"