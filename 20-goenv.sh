if [[ -x "$(which goenv)" ]]; then
	export GOENV_ROOT="$HOME/.goenv"
	export PATH="$GOENV_ROOT/bin:$PATH"
	eval "$(goenv init -)"
	export PATH="$GOROOT/bin:$PATH"
	export PATH="$PATH:$GOPATH/bin"
fi