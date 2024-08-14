# FNM (see https://github.com/Schniz/fnm)
if [ -x "$BREW_HOME/bin/fnm" ]; then
	export PATH=$HOME/.fnm:$PATH
	eval "`fnm env`"
fi


