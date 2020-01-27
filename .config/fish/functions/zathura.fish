# Defined in - @ line 1
function zathura --description 'alias zathura swaymsg exec zathura'
	swaymsg exec zathura (pwd)/$argv;
end
