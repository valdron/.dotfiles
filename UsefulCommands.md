# List of rarely used commands for savekeeping

# Grep with context viewing 2 extra lines 
# Tags: grep, rg, context, lines, search 
rg 'needle' --context 2 file.txt

# view and choose pacman packages using fzf
# pacman, fzf, removing, packages
pacman -Q | cut -d' ' -f1 | fzf --preview='pacman -Qi {}' -m
