# ZSH CONF
fpath+=~/.zfunc
autoload -Uz compinit promptinit
compinit
promptinit
export PATH=/home/paul/.cargo/bin/:$PATH

# GPG_AGENT Conf
GPG_TTY=$(tty)
export GPG_TTY
gpg-connect-agent /bye
echo UPDATESTARTUPTTY | gpg-connect-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"
fi


#ALIAS
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ls='echo use exa'
alias l='exa -la'
alias find='echo use fd'
alias e='vim `fd --hidden | fzf --reverse -m --preview="bat --color=always --decorations=always {}"`'
alias p='swaymsg exec zathura `fd -e pdf | fzf`'
alias c='cd `fd -t d | fzf --preview="exa -la --color=always {}"`'
alias cat='echo use bat'

function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(bat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(bat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}


bindkey -s '^O' 'ranger-cd\n'

config config status.showUntrackedFiles no

# Functions
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi  
    rm -f -- "$tempfile"
}

function termite-cd {
	/usr/bin/termite &
	disown %/usr/bin/termite
}

bindkey -s '^T' 'termite-cd\n'
bindkey -s '^O' 'ranger-cd\n'
# OH_MY_ZSH CONFIG
ZSH=/usr/share/oh-my-zsh/

ZSH_THEME="agnoster"
DISABLE_AUTO_UPDATE="true"
plugins=(git)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
