# PS1
#
# Basic (incomplete) ANSI escape codes to color output:
#
# Black        0;30     Gray          1;30     Dark Gray   2;30
# Red          0;31     Light Red     1;31     Dark Red    2;31
# Green        0;32     Light Green   1;32     Dark Green  2;32
# Orange       0;33     Light Orange  1;33     Dark Orange 2;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

NOCOL="\[\e[0m\]"

__exit_code () {
  local previous_exit_code=$?
  
  if [ $previous_exit_code -eq 0 ]; then
    echo "\[\e[1;32m\][✔ $previous_exit_code]$NOCOL"
  else
    echo "\[\e[1;31m\][✘ $previous_exit_code]$NOCOL"
  fi
}

__username () {
  local userid=$(id -u)
  
  if [ $userid -eq 0 ]; then
    echo "\[\e[2;31m\]\u$NOCOL"
  else
    echo "\[\e[2;32m\]\u$NOCOL"
  fi
}

__host () {
  echo "\[\e[2;36m\]\h$NOCOL"
}

__path () {
  echo "\[\e[2;33m\]\w$NOCOL"
}

__prompt () {
  echo "↳ $NOCOL"
}

__separator () {
  echo "\[\e[1;30m\]$1$NOCOL"
}

__set_ps1 () {
  export PS1="$(__exit_code) $(__username)$(__separator @)$(__host)$(__separator :)$(__path) $(__posh_git_echo)\n$(__prompt)"
}

export PROMPT_COMMAND="__set_ps1"
