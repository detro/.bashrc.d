if [[ -x "$(brew --prefix)/bin/eza" ]]; then
	info "📇 Detected 'eza': aliasing it over 'ls'"
	# eza, on macos
	alias ls='eza --icons=auto --hyperlink --time-style=iso --color=auto --color-scale=all'
fi
