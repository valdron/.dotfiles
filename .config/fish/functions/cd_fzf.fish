function cd_fzf
   set dir (fd -t d | fzf --preview="exa -la --color=always {}") 
   and cd $dir
end

