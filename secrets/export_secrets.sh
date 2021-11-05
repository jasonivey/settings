#!/usr/bin/env bash
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=sh

pushd "$(dirname "$(readlink -f "$0")")" > /dev/null

if command -v git-secret &> /dev/null; then
    export IPINFO_API_KEY="$(git secret cat secrets/ipinfo.api.key.secret)"
    if [[ -e $HOME/settings/secrets/.wakatime.cfg.in ]]; then
        cat $HOME/settings/secrets/.wakatime.cfg.in | sed "s/%WAKATIME_API_KEY%/$(git secret cat secrets/wakatime.api.key.secret)/g" > $HOME/.wakatime.cfg
    fi
fi

popd > /dev/null
