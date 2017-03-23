#!/bin/sh

CC=clang-3.8
export CC

CXX=clang++-3.8
export CXX

UBSAN_OPTIONS=print_stacktrace=1
export UBSAN_OPTIONS

CLANG_PATH=$(mktemp -d)
ln -s "$(whereis llvm-symbolizer-3.8)" "${CLANG_PATH}/llvm-symbolizer"
PATH="${CLANG_PATH}:${PATH}"
export PATH

./autotools.sh \
  CFLAGS="-fsanitize=undefined -fno-sanitize-recover=undefined -fno-sanitize=vptr" \
  CXXFLAGS="-fsanitize=undefined -fno-sanitize-recover=undefined -fno-sanitize=vptr" \
  --without-haxe
