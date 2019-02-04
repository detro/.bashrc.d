# GRC (see https://github.com/garabik/grc)
[[ -s "/etc/grc.bashrc" ]] && source /etc/grc.bashrc

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# NVM (see https://github.com/creationix/nvm)
[ -d "$HOME/.nvm" ] && [ -s "$HOME/.nvm/nvm.sh" ] && source "$HOME/.nvm/nvm.sh"
[ -d "$HOME/.nvm" ] && [ -s "$HOME/.nvm/bash_completion" ] && source "$HOME/.nvm/bash_completion"

# Rust(up) (see https://rustup.rs/)
[ -d "$HOME/.cargo/bin" ] && export PATH="$HOME/.cargo/bin:$PATH"
