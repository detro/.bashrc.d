# Kubectl auto-completion
which kubectl &>/dev/null && source <(kubectl completion bash)

# Alias and ensure completion works for the alias too
alias k='kubectl'
complete -F __start_kubectl k

# Editor for `kubectl edit`
if which subl &>/dev/null; then
    export KUBE_EDITOR="subl -w"
elif which vim &>/dev/null; then
    export KUBE_EDITOR="vim"
fi