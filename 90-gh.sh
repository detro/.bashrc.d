if which gh &>/dev/null; then
	info "⌨️ Setting up 'gh' (GitHub) Bash completion"
	source <(gh completion -s bash)
fi