# GRC (see https://github.com/garabik/grc)
if [[ "MACOSX" == ${OSNAME} ]] && [[ -x "$(which brew)" ]] && [[ -f "$(brew --prefix)/etc/grc.bashrc" ]]; then
	source "$(brew --prefix)/etc/grc.bashrc"
else
	[[ -s "/etc/grc.bashrc" ]] && source /etc/grc.bashrc
fi