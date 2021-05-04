#!/usr/bin/env bash
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=sh

pushd "$(dirname "$(readlink -f "$0")")" > /dev/null

cat $HOME/settings/secrets/.wakatime.cfg.in | sed "s/%WAKATIME_API_KEY%/$(git secret cat wakatime.api.key.secret)/g" > $HOME/.wakatime.cfg

popd > /dev/null
