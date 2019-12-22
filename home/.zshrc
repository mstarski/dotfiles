export ZSH="/home/michals/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Set vim as a default editor
export EDITOR=nvim

# Add Scripts dir to the PATH variable
export PATH=$PATH:/home/michals/Desktop/Scripts

export PATH=$PATH:/home/michals/.local/bin

# Disable loading ranger's default config
export RANGER_LOAD_DEFAULT_RC="false"

# Add npm global to the path (avoid permission errors)
export PATH=~/.npm-global/bin:$PATH

# Make homeshick command visible to the system
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# Enable vi mode in zsh
bindkey -v
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Make things visible for the system
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Aliases
alias gs='git status'
alias gc='git commit'
alias ga='git add'
alias gcam='git commit -am'
alias gp='git push'
alias gpom='git push origin master'
alias gpl='git pull'
alias gplom='git pull origin master'
alias gcout='git checkout'
alias gnewb='git checkout -b'
alias ginit='git init'
alias greset='git reset --hard'
alias arcp='arc patch'
alias arcd='arc diff'
alias nmclean='rm -rf node_modules && npm ci'
alias gstash='git stash'
alias gclean='git clean -df'
alias gbranch='git branch'
alias catt='cat xargs | less'
alias files='xdg-open .'
alias arcdu='arc diff --update'
alias zat='zathura --mode fullscreen'
alias vim='nvim'
alias hsh='homeshick'
alias myfind='find ./** -type f -name'
alias firefox='.local/firefox-developer-edition/firefox-bin'

# Makes ranger change dir to the one we are in when exiting
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi  
    rm -f -- "$tempfile"
}


# Open ranger on ctrl+o (ranger-cd means that it'll change dir when closed)
bindkey -s '^O' 'ranger-cd\n'

ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}
