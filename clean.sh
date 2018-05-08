#!/bin/bash
# vim:softtabstop=4:ts=4:sw=4:expandtab:tw=120

set -e

git clean -xdfn

read -n 1 -p "Do you wish to clean this repository (y/n)? " answer
echo
case ${answer:0:1} in
    y|Y )
        git clean -xdf
    ;;
    * )
    ;;
esac
