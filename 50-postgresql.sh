if [[ -d "$(brew --prefix)/opt/postgresql@16/bin" ]]; then
	export PATH="$(brew --prefix)/opt/postgresql@16/bin:$PATH"
fi
