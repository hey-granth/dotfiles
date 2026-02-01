# =========================
# ZSH — clean, fast, sane
# =========================

# ---------- Basics ----------
export ZSH_DISABLE_COMPFIX=true
export EDITOR=nano
export VISUAL=nano
export PAGER=less

setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt NO_BEEP

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# ---------- Completion ----------
autoload -Uz compinit
compinit -u

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/.zcompcache

# Git completion speedup
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash

# ---------- zoxide ----------
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# ---------- Prompt ----------
autoload -Uz colors vcs_info
colors

setopt PROMPT_SUBST

zstyle ':vcs_info:git:*' formats '%F{magenta}(%b)%f'
zstyle ':vcs_info:*' enable git

precmd() {
  vcs_info
}

PROMPT='%F{cyan}%n@%m%f %F{blue}%~%f ${vcs_info_msg_0_}
%F{green}❯%f '

# ---------- Cursor Shape ----------
# Beam in insert mode, block in normal mode
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    print -n '\e[2 q'
  else
    print -n '\e[6 q'
  fi
}
zle -N zle-keymap-select
print -n '\e[6 q'

# ---------- Keybindings ----------
bindkey -e
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^K' kill-line
bindkey '^U' backward-kill-line

# ---------- Aliases ----------
alias ll='ls -lh'
alias la='ls -lha'
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'

# =========================
# Aliases (ported from bash)
# =========================

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls'

alias cls='clear'

alias tree='tree -I "node_modules|dist|.git|__pycache__"'

alias obsidian="$HOME/Downloads/Obsidian.AppImage"

# Django
alias migrate='python3 manage.py migrate'
alias makemigrations='python3 manage.py makemigrations'
alias migrations='python3 manage.py makemigrations && python3 manage.py migrate'
alias runserver='python3 manage.py runserver'
alias shell='python3 manage.py shell'
alias csu='python3 manage.py createsuperuser'
alias createsuperuser='python3 manage.py createsuperuser'
alias check='python3 manage.py check'
alias showmigrations='python3 manage.py showmigrations'
alias test='python3 manage.py test'

# Python / UV
alias freeze='uv pip freeze > requirements.txt'

# System
alias update='sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo apt clean'

# Git
alias aajkyakiya='git log --author="granth" --since="yesterday" --until="today"'

# Notifications (works in zsh)
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n1 | sed -e '\''s/^[[:space:]]*[0-9]\+[[:space:]]*//;s/[;&|][[:space:]]*alert$//'\'')"'


# ---------- Path ----------
export PATH="$HOME/.local/bin:$PATH"
