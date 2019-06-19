GPG_TTY=$(tty)
export GPG_TTY
gpg-connect-agent /bye
echo UPDATESTARTUPTTY | gpg-connect-agent
unset SSH_AGENT_PID
export _JAVA_AWT_WM_NONREPARENTING=1
alias ls=exa
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"
fi

#ALIAS
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config status.showUntrackedFiles no
