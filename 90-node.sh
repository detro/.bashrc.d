if [[ -f ~/.npmrc ]]; then
	info "💩 Exporting NPM_TOKEN"
	export NPM_TOKEN=$(cut -d= -f2 ~/.npmrc)
fi