if which op &>/dev/null; then
  info "🏦 Setup: 1Password CLI (op)"
	source <(op completion bash)

	if [ -f "${HOME}/.config/op/plugins.sh" ]; then
		source ${HOME}/.config/op/plugins.sh
	fi
fi
