### ENV ###
export PATH="$HOME/.local/bin:$PATH"

#### NVM ####
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"

#### PYENV ####
export PYENV_ROOT="$HOME/.pyenv"
[ -d "$PYENV_ROOT/bin" ] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null 2>&1 && eval "$(pyenv init -)"

#### RBENV ####
[ -d "$HOME/.rbenv/bin" ] && export PATH="$HOME/.rbenv/bin:$PATH"
command -v rbenv >/dev/null 2>&1 && eval "$(rbenv init -)"

#### PHPENV ####
[ -d "$HOME/.phpenv/bin" ] && export PATH="$HOME/.phpenv/bin:$PATH"
command -v phpenv >/dev/null 2>&1 && eval "$(phpenv init -)"

#### COMPLETION / HOOKS
autoload -Uz compinit add-zsh-hook vcs_info colors
mkdir -p ${ZDOTDIR:-$HOME}/.cache/zsh
[ -f "$HOME/.zsh_completions" ] && . "$HOME/.zsh_completions"
compinit -d ${ZDOTDIR:-$HOME}/.cache/zsh/compdump
setopt prompt_subst
zmodload zsh/complist

# timing / exit-status
_ts_preexec() { _ZSH_CMD_BEG=$EPOCHREALTIME }
_ts_precmd() {
  (( ${+_ZSH_CMD_BEG} )) && {
    local d=$(( EPOCHREALTIME - _ZSH_CMD_BEG ))
    _ZSH_LAST_DUR=$(printf '%.2fs' $d)
    unset _ZSH_CMD_BEG
  }
  _ZSH_LAST_STATUS=$?
}

# vcs + hooks
add-zsh-hook precmd vcs_info
add-zsh-hook preexec _ts_preexec
add-zsh-hook precmd  _ts_precmd


# syntax/suggestions
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && . /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'

#### PROMPT ####
PROMPT='%F{magenta}%* %D{%a %b %d}%f %F{green}%B[%~]%b%f %F{cyan}${vcs_info_msg_0_}%f > '

#### ALIASES ####
[ -f "$HOME/.zsh_aliases" ] && . "$HOME/.zsh_aliases"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
