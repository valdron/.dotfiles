set -g current_bg NONE
set segment_separator \uE0B0
set right_segment_separator \uE0B0
set -q scm_prompt_blacklist; or set scm_prompt_blacklist
set -q color_virtual_env_bg; or set color_virtual_env_bg white
set -q color_virtual_env_str; or set color_virtual_env_str black
set -q color_user_bg; or set color_user_bg 444444
set -q color_user_str; or set color_user_str yellow
set -q color_dir_bg; or set color_dir_bg blue
set -q color_dir_str; or set color_dir_str black
set -q color_hg_changed_bg; or set color_hg_changed_bg yellow
set -q color_hg_changed_str; or set color_hg_changed_str black
set -q color_hg_bg; or set color_hg_bg green
set -q color_hg_str; or set color_hg_str black
set -q color_git_dirty_bg; or set color_git_dirty_bg yellow
set -q color_git_dirty_str; or set color_git_dirty_str black
set -q color_git_bg; or set color_git_bg green
set -q color_git_str; or set color_git_str black
set -q color_svn_bg; or set color_svn_bg green
set -q color_svn_str; or set color_svn_str black
set -q color_status_nonzero_bg; or set color_status_nonzero_bg black
set -q color_status_nonzero_str; or set color_status_nonzero_str red
set -q color_status_superuser_bg; or set color_status_superuser_bg black
set -q color_status_superuser_str; or set color_status_superuser_str yellow
set -q color_status_jobs_bg; or set color_status_jobs_bg black
set -q color_status_jobs_str; or set color_status_jobs_str cyan
set -q fish_git_prompt_untracked_files; or set fish_git_prompt_untracked_files normal


set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_char_dirtystate '±'
set -g __fish_git_prompt_char_cleanstate ''

function parse_git_dirty
  if [ $__fish_git_prompt_showdirtystate = "yes" ]
    set -l submodule_syntax
    set submodule_syntax "--ignore-submodules=dirty"
    set untracked_syntax "--untracked-files=$fish_git_prompt_untracked_files"
    set git_dirty (command git status --porcelain $submodule_syntax $untracked_syntax 2> /dev/null)
    if [ -n "$git_dirty" ]
        echo -n "$__fish_git_prompt_char_dirtystate"
    else
        echo -n "$__fish_git_prompt_char_cleanstate"
    end
  end
end

function prompt_segment -d "Function to draw a segment"
  set -l bg
  set -l fg
  if [ -n "$argv[1]" ]
    set bg $argv[1]
  else
    set bg normal
  end
  if [ -n "$argv[2]" ]
    set fg $argv[2]
  else
    set fg normal
  end
  if [ "$current_bg" != 'NONE' -a "$argv[1]" != "$current_bg" ]
    set_color -b $bg
    set_color $current_bg
    echo -n "$segment_separator "
    set_color -b $bg
    set_color $fg
  else
    set_color -b $bg
    set_color $fg
    echo -n " "
  end
  set current_bg $argv[1]
  if [ -n "$argv[3]" ]
    echo -n -s $argv[3] " "
  end
end

function prompt_finish -d "Close open segments"
  if [ -n $current_bg ]
    set_color normal
    set_color $current_bg
    echo -n "$segment_separator "
    set_color normal
  end
  set -g current_bg NONE
end

function prompt_user
    set USER (whoami)
    set HOSTNAME (hostname)
    set PROMPT $USER@$HOSTNAME
    prompt_segment $color_user_bg $color_user_str $PROMPT
end

function prompt_dir -d "Display the current directory"
  prompt_segment $color_dir_bg $color_dir_str (prompt_pwd)
end

function prompt_git -d "Display the current git state"
  set -l ref
  set -l dirty
  if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
    set dirty (parse_git_dirty)
    set ref (command git symbolic-ref HEAD 2> /dev/null)
    if [ $status -gt 0 ]
      set -l branch (command git show-ref --head -s --abbrev |head -n1 2> /dev/null)
      set ref "➦ $branch "
    end
    set branch_symbol \uE0A0
    set -l branch (echo $ref | sed  "s-refs/heads/-$branch_symbol -")
    if [ "$dirty" != "" ]
      prompt_segment $color_git_dirty_bg $color_git_dirty_str "$branch $dirty"
    else
      prompt_segment $color_git_bg $color_git_str "$branch $dirty"
    end
  end
end

function prompt_status -d "the symbols for a non zero exit status, root and background jobs"
    if [ $RETVAL -ne 0 ]
      prompt_segment $color_status_nonzero_bg $color_status_nonzero_str "✘"
    end

    # if superuser (uid == 0)
    set -l uid (id -u $USER)
    if [ $uid -eq 0 ]
      prompt_segment $color_status_superuser_bg $color_status_superuser_str "⚡"
    end

    # Jobs display
    if [ (jobs -l | wc -l) -gt 0 ]
      prompt_segment $color_status_jobs_bg $color_status_jobs_str "⚙"
    end
end

function fish_prompt
  set -g RETVAL $status
  prompt_status
  prompt_user
  prompt_dir
  prompt_git
  prompt_finish
end
