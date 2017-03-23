#!/bin/sh

set -ex

#sudo apt-get update
sudo apt-get install -y clang-3.8

CC=clang-3.8
export CC

CXX=clang++-3.8
export CXX

UBSAN_OPTIONS=print_stacktrace=1
export UBSAN_OPTIONS

CLANG_PATH=$(mktemp -d)
ln -s "$(whereis llvm-symbolizer-3.8  | rev | cut -d ' ' -f 1 | rev)" \
  "${CLANG_PATH}/llvm-symbolizer"
ls -l "${CLANG_PATH}"
PATH="${CLANG_PATH}:${PATH}"
export PATH

#  --without-haxe

CFLAGS='-fsanitize=undefined -fno-sanitize-recover=undefined -fno-sanitize=vptr -O0 -ggdb3'
export CFLAGS

CXXFLAGS='-fsanitize=undefined -fno-sanitize-recover=undefined -fno-sanitize=vptr -O0 -ggdb3'
export CXXFLAGS

build/docker/scripts/autotools.sh
