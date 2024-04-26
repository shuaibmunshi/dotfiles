# Install

### Homebrew
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Config Alias
```
alias config='/usr/bin/git --git-dir=$HOME/repos/dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config status
config commit -am "blah blah blah"
config push
```

### fzf
```
brew install fzf
$(brew --prefix)/opt/fzf/install
```

### p10k
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
source ~/.zshrc
# Might not need to do this
p10k configure
```


### Autocomplete
```
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
```
### VSCode
```
config add $HOME/Library/Application\ Support/Code/User/settings.json
code $HOME/Library/Application\ Support/Code/User/settings.json
```

### Kubectl
```
brew install kubectl
```