# Setup chruby (https://github.com/postmodern/chruby) on macOS,
# based on https://jekyllrb.com/docs/installation/macos/.
if [[ -x "$(brew --prefix)/opt/chruby/" ]]; then
	# Enables chruby
	source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh

	# Enables chruby auto-switching of Rubies based on `.ruby-version` file
	source $(brew --prefix)/opt/chruby/share/chruby/auto.sh
fi