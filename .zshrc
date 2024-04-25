################
# Alias Config #
################
echo "-----------------------------"
echo "Configuring aliases..." >&2
if [ -x "$(command -v git)" ]; then
    echo "Alias: config='/usr/bin/git --git-dir=$HOME/repos/dotfiles/ --work-tree=$HOME'" >&2
    alias config='/usr/bin/git --git-dir=$HOME/repos/dotfiles/ --work-tree=$HOME' >&2
fi

if [ -f /usr/local/bin/code ]; then
    if [ -x "$(command -v code)" ]; then
        echo "Alias: code="/usr/local/bin/code"" >&2
        alias code="/usr/local/bin/code" >&2
    fi
fi

if [ -x "$(command -v caffeinate)" ]; then
    echo "Alias: coffee="caffeinate"" >&2
    alias coffee="caffeinate" >&2
fi

if [ -x "$(command -v ansible-playbook)" ]; then
    echo "Alias: ap="ansible-playbook"" >&2
    alias ap="ansible-playbook" >&2
fi

if [ -x "$(command -v pyenv)" ]; then
    echo "Configuring pyenv" >&2
    eval "$(pyenv init - | sed 's:^pyenv() :function pyenv():')" >&2
    export PATH=$(pyenv root)/shims:$PATH 
fi

if [ -x "$(command -v fzf)" ]; then
    echo "Configuring fzf" >&2
    eval "$(fzf --zsh)" >&2
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"


# if [ -f ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate/ohmyzsh-full-autoupdate.plugin.zsh ]; then
#     echo "Installing ohmyzsh-full-autoupdate"
#     git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate
# fi

source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete 

plugins=(git fzf-tab ohmyzsh-full-autoupdate docker)

source $ZSH/oh-my-zsh.sh

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

################
#    HISTORY   #
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
# Execute commands using history (e.g.: using !$) immediatel:
unsetopt HIST_VERIFY