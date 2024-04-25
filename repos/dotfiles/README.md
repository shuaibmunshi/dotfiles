#Install

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

config config --local status.showUntrackedFiles no

brew install fzf
$(brew --prefix)/opt/fzf/install

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
source ~/.zshrc
# Might not need to do this
p10k configure

alias config='/usr/bin/git --git-dir=$HOME/repos/dotfiles/ --work-tree=$HOME'
config status
config commit -am "blah blah blah"
config push

code ~/.zshrc

git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete