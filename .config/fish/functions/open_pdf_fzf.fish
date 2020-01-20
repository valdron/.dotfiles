function open_pdf_fzf
    set file (fd -e pdf | fzf)
    and swaymsg exec zathura $file    
end

