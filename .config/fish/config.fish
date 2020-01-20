# PATH
set -x PATH $PATH /home/paul/.cargo/bin

# GPG AGENT
set -x GPG_TTY (tty)
gpgconf --launch gpg-agent

# Ensure that GPG Agent is used as the SSH agent
set -e SSH_AUTH_SOCK
set -U -x SSH_AUTH_SOCK /run/user/(id -u)/gnupg/S.gpg-agent.ssh

abbr -a -g config dotfiles_git 
abbr -a -g l exa -la
abbr -a -g e edit_file_fzf
abbr -a -g p open_pdf_fzf
abbr -a -g c cd_fzf

dotfiles_git config status.showUntrackedFiles no
dotfiles_git status


if status is-login
    if test -z "$DISPLAY" -a (tty) = "/dev/tty1"
        set -x XKB_DEFAULT_LAYOUT=de 
        exec sway
    end
end

