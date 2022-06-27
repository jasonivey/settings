#!/usr/bin/env bash
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=sh

get_date_format() {
    echo '+%I:%M:%S%P'
}

get_color_code() {
    local input=$1
    case $input in
        bold-black)
            echo -ne "\e[30;1m" ;;
        bright-black)
            echo -ne "\e[90m" ;;
        black)
            echo -ne "\e[30m" ;;
        bold-red)
            echo -ne "\e[31;1m" ;;
        bright-red)
            echo -ne "\e[91m" ;;
        red)
            echo -ne "\e[31m" ;;
        bold-green)
            echo -ne "\e[32;1m" ;;
        bright-green)
            echo -ne "\e[92m" ;;
        green)
            echo -ne "\e[32m" ;;
        bold-yellow)
            echo -ne "\e[33;1m" ;;
        bright-yellow)
            echo -ne "\e[93m" ;;
        yellow)
            echo -ne "\e[33m" ;;
        bold-blue)
            echo -ne "\e[34;1m" ;;
        bright-blue)
            echo -ne "\e[94m" ;;
        blue)
            echo -ne "\e[34m" ;;
        bold-magenta)
            echo -ne "\e[35;1m" ;;
        bright-magenta)
            echo -ne "\e[95m" ;;
        magenta)
            echo -ne "\e[35m" ;;
        bold-cyan)
            echo -ne "\e[36;1m" ;;
        bright-cyan)
            echo -ne "\e[96m" ;;
        cyan)
            echo -ne "\e[36m" ;;
        bold-white)
            echo -ne "\e[37;1m" ;;
        bright-white)
            echo -ne "\e[97m" ;;
        white)
            echo -ne "\e[37m" ;;
        reset)
            echo -ne "\e[0m" ;;
        *)
            echo -ne "\e[0m" ;;
    esac
}

print_error() {
    local error_prefix="$(get_color_code "bold-red")ERROR"
    local date_str="$(get_color_code "cyan")$(date "$(get_date_format)")"
    local location_str="$(get_color_code "cyan")export_secrets.sh:$1"
    local date_location="$(get_color_code "bright-white")[${date_str}$(get_color_code "bright-white") @ ${location_str}$(get_color_code "bright-white")]"
    local msg="$2$(get_color_code "reset")"
    echo "${error_prefix} ${date_location}: ${msg}"
}

export_git_secrets() {
    if ! command -v gpg &> /dev/null; then
        print_error "${LINENO}" "gpg has not been installed"
        return
    fi

    if ! command -v git-secret &> /dev/null; then
        print_error "${LINENO}" "git-secret has not been installed"
        return
    fi

    if git secret cat secrets/ipinfo.api.key.secret &> /dev/null; then
        export IPINFO_API_KEY="$(git secret cat secrets/ipinfo.api.key.secret)"
    fi

    if [[ ! -e $HOME/settings/secrets/.wakatime.cfg.in ]]; then
        print_error "${LINENO}" "file not found, .wakatime.cfg.in"
        return
    fi

    if git secret cat secrets/wakatime.api.key.secret &> /dev/null; then
        cat $HOME/settings/secrets/.wakatime.cfg.in | sed "s/%WAKATIME_API_KEY%/$(git secret cat secrets/wakatime.api.key.secret)/g" > $HOME/.wakatime.cfg
    fi
}

main() {
    pushd "$(dirname "$(readlink -f "$0")")" &> /dev/null
    export_git_secrets
    popd &> /dev/null
}

main
