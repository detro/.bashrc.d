# Starship: https://starship.rs/
if [[ -x "$(brew --prefix)/bin/starship" ]]; then
	eval "$(starship init bash)"
fi