#!/usr/bin/env bash
# vim:softtabstop=4:ts=4:sw=4:expandtab:tw=120

set -e

if [ "$(uname)" == "Darwin" ]; then
    COMPILER=clang 
elif [ "$(uname -s)" == "Linux" ]; then
    COMPILER=clang-3.8
fi

echo
echo "Building/Testing libqmx clang debug"
./waf configure --clang=$COMPILER "$@"
./waf build install check "$@"

echo
echo "Successfully built and tested libqmx"

