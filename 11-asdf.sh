# ASDF installed with the "Bash & Git" method
# See: https://asdf-vm.com/guide/getting-started.html#_3-install-asdf

if [[ -e "$HOME/.asdf/asdf.sh" ]]; then
	. $HOME/.asdf/asdf.sh
	. $HOME/.asdf/completions/asdf.bash
fi

