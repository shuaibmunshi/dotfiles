# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Plugins
plugins=(git fzf-tab ohmyzsh-full-autoupdate docker kubectl zsh-fzf-history-search)

source $ZSH/oh-my-zsh.sh

################
# HISTORY      #
################
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
# Immediately append to history file:
setopt INC_APPEND_HISTORY
# Record timestamp in history:
setopt EXTENDED_HISTORY
# Expire duplicate entries first when trimming history:
setopt HIST_EXPIRE_DUPS_FIRST
# Dont record an entry that was just recorded again:
setopt HIST_IGNORE_DUPS
# Delete old recorded entry if new entry is a duplicate:
setopt HIST_IGNORE_ALL_DUPS
# Do not display a line previously found:
setopt HIST_FIND_NO_DUPS
# Dont record an entry starting with a space:
setopt HIST_IGNORE_SPACE
# Dont write duplicate entries in the history file:
setopt HIST_SAVE_NO_DUPS
# Share history between all sessions:
setopt SHARE_HISTORY
# Execute commands using history (e.g.: using !$) immediately:
unsetopt HIST_VERIFY

################
# Completions  #
################
# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/shuaib/.zsh/completions:"* ]]; then
  export FPATH="/home/shuaib/.zsh/completions:$FPATH"
fi

# macOS brew completions
if [[ `uname` == "Darwin" ]]; then
  # https://docs.brew.sh/Shell-Completion
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

fpath=(~/.zsh $fpath)

# Optimize compinit - only rebuild cache once per day
autoload -Uz compinit
if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

################
# PATH Setup   #
################
# Build PATH efficiently
path=(
  ${HOME}/.local/bin(N-/)
  /usr/local/go/bin(N-/)
  ${HOME}/go/bin(N-/)
  ${HOME}/.cargo/bin(N-/)
  ${HOME}/.claude/local(N-/)
  $path
)

# Pyenv
if (( $+commands[pyenv] )); then
  export PATH="$(pyenv root)/shims:$PATH"
  eval "$(pyenv init -)"
fi

export PATH

################
# Alias Config #
################
# Git dotfiles management
(( $+commands[git] )) && alias config='/usr/bin/git --git-dir=$HOME/repos/dotfiles/ --work-tree=$HOME'

# VS Code
[[ -x /usr/local/bin/code ]] && alias code="/usr/local/bin/code"

# Caffeinate (macOS)
(( $+commands[caffeinate] )) && alias coffee="caffeinate"

# Ansible
(( $+commands[ansible-playbook] )) && alias ap="ansible-playbook"

# Neovim
(( $+commands[nvim] )) && alias vi="nvim"

# Kubectl
if (( $+commands[kubectl] )); then
  source <(kubectl completion zsh)
  alias k="kubectl"
fi

# Tailscale
alias ts="tailscale status"

# Claude
alias claude="/home/shuaib/.claude/local/claude"

################
# Tool Configs #
################
# FZF
if (( $+commands[fzf] )); then
  eval "$(fzf --zsh)"
fi

# Zoxide (replaces cd)
if (( $+commands[zoxide] )); then
  eval "$(zoxide init --cmd cd zsh)"
fi

# Google Cloud SDK (update paths if needed)
# if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
#   . "$HOME/google-cloud-sdk/path.zsh.inc"
# fi
# if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
#   . "$HOME/google-cloud-sdk/completion.zsh.inc"
# fi

# Local environment variables
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
