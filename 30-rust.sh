# Rust(up) (see https://rustup.rs/)
if [[ -d "$HOME/.cargo" ]]; then
	source "$HOME/.cargo/env"
	export PATH="$HOME/.cargo/bin:$PATH"
fi
