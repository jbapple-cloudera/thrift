#!/bin/sh

set -ex

sudo apt-get update
sudo apt-get install -y --no-install-recommends clang-3.8 llvm-3.8-dev

export CC=clang-3.8
export CXX=clang++-3.8
export CFLAGS="-fsanitize=undefined -fno-sanitize-recover=undefined -fno-sanitize=vptr -O0 -ggdb3"
export CXXFLAGS="${CFLAGS}"
export UBSAN_OPTIONS=print_stacktrace=1

CLANG_PATH=$(mktemp -d)
ln -s "$(whereis llvm-symbolizer-3.8  | rev | cut -d ' ' -f 1 | rev)" \
  "${CLANG_PATH}/llvm-symbolizer"
ls -l "${CLANG_PATH}"
export PATH="${CLANG_PATH}:${PATH}"
llvm-symbolizer -version

build/docker/scripts/autotools.sh $*
