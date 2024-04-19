# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
#

# Themes, See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Auto correction of misspelled commands
ENABLE_CORRECTION="false"

DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=( git z zsh-autosuggestions vi-mode)

bindkey -v
bindkey '^O' autosuggest-accept

source $ZSH/oh-my-zsh.sh

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# Set up fzf key bindings and fuzzy completion
source /usr/share/fzf/shell/key-bindings.zsh
