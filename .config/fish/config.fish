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
set -U FZF_OPEN_COMMAND "fd --hidden --type f . \$dir"
set -U FZF_CD_COMMAND "fd --type d . \$dir"
set -U FZF_CD_WITH_HIDDEN_COMMAND "fd --hidden --type d . \$dir"
set -U FZF_PREVIEW_DIR_CMD "exa -la --color=always"
set -U FZF_PREVIEW_FILE_CMD "bat --color=always --decorations=always"
set -U FZF_ENABLE_OPEN_PREVIEW 1
set -U FZF_CD_WITH_HIDDEN_OPTS '--preview="$FZF_PREVIEW_DIR_CMD {}"'
set -U FZF_CD_OPTS '--preview="$FZF_PREVIEW_DIR_CMD {}"'

# wayland functions
set -U -x MOZ_ENABLE_WAYLAND 1
set -U -x MOZ_WEBRENDER 1
set -U -x QT_QPA_PLATFORM wayland
set -U -x _JAVA_AWT_WM_NONREPARENTING 1

abbr -a -g c dotfiles_git 
abbr -a -g l exa -la
abbr -a -g v vim
abbr -a -g z zathura

# Git Abbrevations
abbr -a -g gc git commit 
abbr -a -g gco git checkout 
abbr -a -g ga git add
abbr -a -g g git

for f in $HOME/.config/fish/conf.d/*
    source f
end

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

