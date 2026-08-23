if [[ -x "$(brew --prefix)/bin/eza" ]]; then
	info "📇 Aliasing: ls -> eza"
	# eza, on macos
	alias ls='eza --icons=auto --hyperlink --time-style=iso --color=auto --color-scale=all'
fi
