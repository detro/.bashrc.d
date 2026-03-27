# Starship: https://starship.rs/
if [[ -x "$(brew --prefix)/bin/starship" ]]; then
	info "⭐️ Setting up Starship for Bash"
	eval "$(starship init bash)"
fi
