# Suggested layout for the Go installation (if using packages from https://golang.org/doc/install):
# ~/.go
#   ├── <VERSION>
#   │   ├── go                      <--- GOROOT
#   │   └── gocache
#   └── current -> <VERSION>
# ~/Workspaces
#   └── go                          <--- GOPATH
#
if [ -d "$HOME/.go/current/go/bin" ]; then
    # If Go is installed in the home directory (as shown above)
    export GOROOT="$HOME/.go/current/go"
    export GOPATH="$HOME/Workspaces/go"
    export GO111MODULE=on
    export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
elif which go &> /dev/null; then
    # If Go is installed on system level

    if [[ -x "$(which brew)" ]] && [[ -d "$(brew --prefix)/opt/go/libexec" ]]; then
        # Only on Mac with Homebrew
        export GOROOT="$(brew --prefix)/opt/go/libexec"
    fi

    export GOPATH="$HOME/Workspaces/go"
    export GO111MODULE=on
    export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
fi
