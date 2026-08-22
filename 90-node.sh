if [[ -f ~/.npmrc ]]; then
	info "💩 Exporting NPM_TOKEN from ~/.npmrc"
	export NPM_TOKEN=$(cut -d= -f2 ~/.npmrc)
fi