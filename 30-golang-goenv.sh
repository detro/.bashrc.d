# Based on: https://github.com/syndbg/goenv/blob/master/INSTALL.md
#
# The only thing you need for this to work, is to git-clone according to the INSTALL
# readme. Then, install the Go version(s) you need.

# Define environment variable GOENV_ROOT to point to the path where goenv repo is cloned
if [[ -d "${HOME}/.goenv" ]]; then
	# Found at `~/.goenv`
	export GOENV_ROOT="${HOME}/.goenv"
	# Found at `/usr/local/opt/goenv`
elif [[ -d "/usr/local/opt/goenv" ]]; then
	export GOENV_ROOT="/usr/local/opt/goenv"
fi

# If `GOENV_ROOT` was found and defined, initialize goenv
if [[ -n "${GOENV_ROOT}" ]]; then
	export PATH="${GOENV_ROOT}/bin:$PATH"

	# Add goenv init to your shell to enable shims, management of GOPATH and GOROOT and auto-completion
	eval "$(goenv init -)"

	# goenv to manage GOPATH and GOROOT (recommended), add GOPATH and GOROOT to your shell
	export PATH="${GOROOT}/bin:${PATH}"
	export PATH="${PATH}:${GOPATH}/bin"
fi