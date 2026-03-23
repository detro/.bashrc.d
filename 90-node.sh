if [[ -f ~/.npmrc ]]; then
	export NPM_TOKEN=$(cut -d= -f2 ~/.npmrc)
fi