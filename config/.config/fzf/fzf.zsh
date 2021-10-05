# Setup fzf
# ---------

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if ! command -v fzf &> /dev/null; then
    if [[ -d /usr/local/opt/fzf/bin ]]; then
        export PATH="${PATH}:/usr/local/opt/fzf/bin"
    fi
fi
# if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
#  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
# fi

# Auto-completion
# ---------------
if [[ -e "/usr/local/opt/fzf/shell/completion.zsh" ]]; then
    source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
elif [[ -e "/usr/share/fzf/completion.zsh" ]]; then
    source "/usr/share/fzf/completion.zsh" 2> /dev/null
fi

# Key bindings
# ------------
# source "/usr/local/opt/fzf/shell/key-bindings.zsh"
if [[ -e "/usr/local/opt/fzf/shell/key-bindings.zsh" ]]; then
    source "/usr/local/opt/fzf/shell/key-bindings.zsh" 2> /dev/null
elif [[ -e "/usr/share/fzf/key-bindings.zsh" ]]; then
    source "/usr/share/fzf/key-bindings.zsh" 2> /dev/null
fi
