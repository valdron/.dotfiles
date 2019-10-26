GPG_TTY=$(tty)
export GPG_TTY
gpg-connect-agent /bye
echo UPDATESTARTUPTTY | gpg-connect-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"
fi

#ENV_VARS
export BEMENU_BACKEND=wayland

#ALIAS
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ls='echo use exa'
alias find='echo use fd'
config config status.showUntrackedFiles no
