function edit_file_fzf
    set file (fd --hidden | fzf --reverse -m --preview="bat --color=always --decorations=always {}")
    and vim $file
end

