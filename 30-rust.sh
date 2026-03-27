# Rust(up) (see https://rustup.rs/)
if [[ -d "$HOME/.cargo" ]]; then
	info "🦀 Detected Rust 'cargo'"
	source "$HOME/.cargo/env"
	export PATH="$HOME/.cargo/bin:$PATH"
fi
