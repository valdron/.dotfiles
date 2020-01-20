function dotfiles_git
     git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
end

