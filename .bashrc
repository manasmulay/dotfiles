function in_git_repo_name {
  ps_git_name="\\[\e[01;33m\\]$(basename `git rev-parse --show-toplevel`)\\[\e[0m\\]"
}

function in_git_repo_branch {
  # if there are uncommitted changes, include an asterisk (*) character
  local star=$(if [ -n "$(git status -s)" ]; then echo ' *'; fi)
  ps_git_branch="\\[\e[01;36m\\]($(git rev-parse --abbrev-ref HEAD)$star)\\[\e[0m\\]"
}

function in_git_repo_dir {
  local base_dir=$(git rev-parse --show-toplevel)
  local esc_base_dir=$(echo $base_dir | sed "s/\//\\\\\//g")
  local rel_path=$(pwd | sed "s/$esc_base_dir\/\?//g")
  if [ `pwd` != $base_dir ]; then ps_git_dir=" \\[\e[01;32m\\]$rel_path\\[\e[0m\\]"; else ps_git_dir=""; fi
}

function set_ps1 {
  if [ -z "$(git rev-parse 2>&1)" ]
    then
      local TERM_TITLE=$(basename `git rev-parse --show-toplevel`)
      in_git_repo_name && in_git_repo_branch && in_git_repo_dir
      PS1="\\[\033]0;$TERM_TITLE\007\\]$ps_git_name $ps_git_branch$ps_git_dir "
    else
      PS1='\[\033]0;\W\007\]\[\e[01;32m\]\u@\h\[\e[0m\]\[\e[01;33m\]:\[\e[0m\]\[\e[01;36m\]\w\[\e[0m\] \[\e[01;38m\]\$\[\e[0m\] '
  fi
}

PROMPT_COMMAND='set_ps1'
alias xrandr-colour='xrandr --output  HDMI-1 --set "Broadcast RGB" "Full"'
