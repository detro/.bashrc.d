if [[ -x "$(brew --prefix)/bin/eza" ]]; then
	# eza, on macos
	alias ls='eza --icons=auto --hyperlink --time-style=iso --color=auto --color-scale=all'
fi