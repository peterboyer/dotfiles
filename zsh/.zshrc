# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="eastwood"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# User configuration
alias cdx="cd ~/dev"
alias cdu="cd ~/untracked"
alias cdd="cd ~/untracked/dotfiles"
function cdp () {
  cd $OLDPWD
}

# config
alias cfgzsh="vim ~/.zshrc"
alias srczsh="source ~/.zshrc"
alias cfgomz="vim ~/.oh-my-zsh"
alias srcomz="source ~/.oh-my-zsh"
alias cfggit="vim ~/.gitconfig"
alias cfgvim="(cd ~/.config/nvim && vim init.lua)"

# dconf helpers
alias dcmpbase="dconf dump / > ~/.settings.dump1"
alias dcmpsnap="dconf dump / > ~/.settings.dump2"
alias dcmpcycle="rm ~/.settings.dump1; mv ~/.settings.dump2 ~/.settings.dump1"
alias dcmpdiff="diff -y ~/.settings.dump1 ~/.settings.dump2"

# neovim ===
alias vim="nvim"

# exa ===
alias ls="exa"
alias l="ls -l"
alias lg="ls -lag"
alias la="ls -la"
alias lag="ls -lag"

# nvm ===
# https://aur.archlinux.org/packages/nvm#comment-764001
source /usr/share/nvm/init-nvm.sh

# dslr-webcam ===
alias dslr-mount="sudo modprobe v4l2loopback exclusive_caps=1 max_buffers=2"
alias dslr-unmount="sudo rmmod v4l2loopback"

alias dslr-ls="ls /dev/video*"
alias dslr-gls="gphoto2 --abilities"

function dslr_stream() {
  # use first arg
  TARGET="$1"
  # if first arg empty, default to last device
  if [[ -z "$1" ]]; then
    TARGET=$(ls -1 /dev/video* | awk 'BEGIN{ RS = "" ; FS = "\n" }{print $NF}')
    echo $TARGET
  fi
  # gphoto output | stream to encoder | stream to device
  gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 $TARGET
}
alias dslr-stream="dslr_stream"

# deport (kill process on port) ===
function deport() {
  TARGET_PORT=$1
  TARGET_PID="$(lsof -i:$TARGET_PORT -t)"
  if [[ -z "$TARGET_PID" ]]; then
    echo "no process on port $TARGET_PORT"
  else
    echo $TARGET_PID | xargs kill
    echo $TARGET_PID | xargs echo
  fi
}

# todo

alias todo="vim ~/untracked/todo"

# docker

# docker-destroy-containers
function ddc() {
  docker ps -a | grep "$1" | awk '{print $1}' | xargs docker rm -f
}

# docker-destroy-untagged-images
function ddui() {
  docker image ls | grep '<none>' | awk '{print $3}' | xargs docker rmi -f
}

# auto-nvm-switching
# https://www.richardhuf.com.au/using-node-version-manager-and-nvmrc-to-automatically-switch-node-versions-per-project/
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  # elif [[ $PWD =~ "$HOME/dev"  ]]; then
  #   nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

EDITOR=vim
