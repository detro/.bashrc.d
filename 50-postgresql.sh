if [[ -d "$(brew --prefix)/opt/postgresql@16/bin" ]]; then
	info "Added 'postgresql/bin' to PATH"
	export PATH="$(brew --prefix)/opt/postgresql@16/bin:$PATH"
fi
