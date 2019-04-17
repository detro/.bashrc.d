# ls
if [[ "MACOSX" == ${OSNAME} ]] || [[ "BSD" == ${OSNAME} ]]; then
	alias ls='ls -FG'
else
	alias ls='ls -F --color=auto'
fi
alias la='ls -A'
alias ll='ls -l'
alias lla='ll -A'
alias llh='ll -h'
alias llha='ll -hA'

# su
alias ssu='sudo -E su -p'

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
