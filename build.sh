#!/usr/bin/env bash
# vim:softtabstop=4:ts=4:sw=4:expandtab:tw=120

set -e

#if [ "$(uname)" == "Darwin" ]; then
#    COMPILER=clang 
#elif [ "$(uname -s)" == "Linux" ]; then
#    COMPILER=clang-3.8
#fi

echo
echo "Building/Testing Datawarehouse Debug"
dvm run BUILD_TYPE=Debug ./cmake-init.sh
dvm run make -j8
dvm run GTEST_COLOR=1 make test ARGS="-V"

echo
echo "Successfully built and tested Datawarehouse"

