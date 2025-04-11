# ASDF installed with the "Bash & Git" method (pre-0.16)
# See: https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
if [[ -e "$HOME/.asdf/asdf.sh" ]]; then
	. $HOME/.asdf/asdf.sh
	. $HOME/.asdf/completions/asdf.bash
fi

## ASDF installed via Homebrew (0.16 and later)
if [[ -e "$(brew --prefix)/opt/asdf/libexec/asdf.sh" ]]; then
	. /opt/homebrew/opt/asdf/libexec/asdf.sh
	. /opt/homebrew/etc/bash_completion.d/asdf
fi