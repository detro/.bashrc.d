# set PATH so it includes user's private ~/bin if it exists
[ -d "$HOME/bin" ] && echo "🏠 Setup PATH: ~/bin" && PATH="$HOME/bin:$PATH"

# set PATH so it includes user's private ~/.local/bin if it exists
[ -d "$HOME/.local/bin" ] && echo "🏠 Setup PATH: ~/.local/bin" && PATH="$HOME/.local/bin:$PATH"
