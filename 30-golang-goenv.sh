# Based on: https://github.com/syndbg/goenv/blob/master/INSTALL.md
if [[ -x "$(which goenv)" ]] && [[ -d "${HOME}/.goenv" ]]; then
	# Define environment variable GOENV_ROOT to point to the path where goenv repo is cloned
	export GOENV_ROOT="${HOME}/.goenv"
	export PATH="${GOENV_ROOT}/bin:$PATH"

	# Add goenv init to your shell to enable shims, management of GOPATH and GOROOT and auto-completion
	eval "$(goenv init -)"

	# goenv to manage GOPATH and GOROOT (recommended), add GOPATH and GOROOT to your shell
	export PATH="${GOROOT}/bin:${PATH}"
	export PATH="${PATH}:${GOPATH}/bin"
fi