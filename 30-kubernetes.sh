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

# Setup a bare-minimum, local port forwarding for a service
k_portfw () {
    if [ $# -ne 3 ]; then
        echo "Usage: k_portfw <SERVICE NAME> <PORT ON LOCALHOST> <PORT ON CLUSTER>"
    else
        kubectl port-forward svc/$1 $2:$3
    fi
}

# Force a service to re-deploy, if the change is not automatically picked up (ex. republished Docker image)
k_kick () {
    if [ $# -ne 1 ]; then
        echo "Usage: k_kick <SERVICE NAME>"
    else
        kubectl patch deployment $1 -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
    fi
}

# Manually triggers a CronJob instead of waiting for next execution
k_cron_kick () {
    if [ $# -ne 1 ]; then
        echo "Usage: k_cron_kick <CRONJOB NAME>"
    else
        kubectl create job --from=cronjob/$1 $1-manual-$(date -u +%s)
    fi
}