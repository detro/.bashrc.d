# Go (see https://golang.org/doc/install)
#
# Assumes this layout for the Go installation:
# ~/.go
#   ├── <VERSION>
#   │   ├── go                      <--- GOROOT
#   │   └── gocache
#   └── current -> <VERSION>
# ~/Workspaces
#   └── go                          <--- GOPATH
#
if [ -d "$HOME/.go/current/go/bin" ]; then
	# Go installed under "~/.go" (Windows, Linux)
    export GOROOT="$HOME/.go/current/go"
    export GOPATH="$HOME/Workspaces/go"
    export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
elif which go &> /dev/null; then
	# Go installed on the system level (macOS)
	export GOPATH="$HOME/Workspaces/go"
	export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
fi
