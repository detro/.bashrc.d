# Kubectl auto-completion
if which kubectl &>/dev/null; then
    KUBECTL_COMPLETION_TMP=$(mktemp kubectl-completion-XXXXX)
    kubectl completion bash > ${KUBECTL_COMPLETION_TMP}
    source ${KUBECTL_COMPLETION_TMP}
    rm ${KUBECTL_COMPLETION_TMP}
fi

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

# Tunnel traffic toward IP/HOSTNAME private to the K8S cluster
k_socat() {
(
    set -euo pipefail

    local HOSTNAME="$1"
    local PORT="$2"
    local LOCAL_PORT="$3"
    local SANITIZED_HOSTNAME=$(echo "${HOSTNAME//[.]/-}" | tr '[:upper:]' '[:lower:]')
    local TEMP_POD_NAME="socat-${USER}-${SANITIZED_HOSTNAME}-${PORT}-$(date +%s)"

    echo "Creating a temporary pod to create a tunnel from ${HOSTNAME}:${PORT} to localhost:${LOCAL_PORT}..."

    kubectl run --restart=Never --image=alpine/socat $TEMP_POD_NAME -- -d -d tcp-listen:$PORT,fork,reuseaddr tcp-connect:$HOSTNAME:$PORT
    kubectl wait --for=condition=Ready pod/$TEMP_POD_NAME

    echo
    echo "Please delete the pod after you're done:"
    echo
    echo "    kubectl delete pod $TEMP_POD_NAME --grace-period 1 --wait=false"
    echo

    kubectl port-forward pod/$TEMP_POD_NAME $LOCAL_PORT:$PORT
)
}