if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  _JAVA_AWT_WM_NONREPARENTING=1 XKB_DEFAULT_LAYOUT=de exec sway
fi
