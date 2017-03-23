#!/bin/sh

set -x

sudo apt-get update
sudo apt-get install -y clang-3.8

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

build/docker/scripts/autotools.sh \
  CFLAGS="-fsanitize=undefined -fno-sanitize-recover=undefined -fno-sanitize=vptr" \
  CXXFLAGS="-fsanitize=undefined -fno-sanitize-recover=undefined -fno-sanitize=vptr" \
  --without-haxe
