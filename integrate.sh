#!/usr/bin/env bash
# vim:softtabstop=4:ts=4:sw=4:expandtab:tw=120

set -e

function clean-build() {
    rm -rf build
}

clean-build

if [ "$(uname)" == "Darwin" ]; then
    COMPILER=clang 
elif [ "$(uname -s)" == "Linux" ]; then
    COMPILER=clang-3.8
fi

echo
echo "Building/Testing libqmx clang debug"
./waf configure --clang=$COMPILER "$@"
./waf clean build install check "$@"

clean-build

echo
echo "Building/Testing libqmx clang release"
./waf configure --clang=$COMPILER --release-build "$@"
./waf clean build install check "$@"

clean-build

if [ "$(uname)" == "Darwin" ]; then
    COMPILER=gcc
elif [ "$(uname -s)" == "Linux" ]; then
    COMPILER=gcc-4.8
fi

echo
echo "Building/Testing libqmx gcc debug"
./waf configure --gcc=$COMPILER "$@"
./waf clean build install check "$@"

clean-build

echo
echo "Building/Testing libqmx gcc release"
./waf configure --gcc=$COMPILER --release-build "$@"
./waf clean build install check "$@"

echo
echo "Successfully built and tested libqmx"
