# PATH
set -x PATH $PATH /home/paul/.cargo/bin

# GPG AGENT
set -x GPG_TTY (tty)
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1

# Ensure that GPG Agent is used as the SSH agent
set -e SSH_AUTH_SOCK
set -U -x SSH_AUTH_SOCK /run/user/(id -u)/gnupg/S.gpg-agent.ssh

# FZF Integrations
set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_FIND_FILE_COMMAND "fd --hidden --type f . \$dir"
set -U FZF_CD_COMMAND "fd --type d . \$dir"
set -U FZF_CD_WITH_HIDDEN_COMMAND "fd --hidden --type d . \$dir"
set -U FZF_PREVIEW_DIR_CMD "exa -la"
set -U FZF_PREVIEW_FILE_CMD "bat --color=always --decorations=always"


abbr -a -g c dotfiles_git 
abbr -a -g l exa -la
abbr -a -g v vim
abbr -a -g z zathura

# Git Abbrevations
abbr -a -g gc git commit 
abbr -a -g gco git checkout 
abbr -a -g ga git add
abbr -a -g g git


if status is-interactive
    dotfiles_git config status.showUntrackedFiles no
    dotfiles_git status
end

if status is-login
    fisher
    if test -z "$DISPLAY" -a (tty) = "/dev/tty1"
        set -x XKB_DEFAULT_LAYOUT=de 
        exec sway
    end
end

