#!/usr/bin/sh

set -eu -o pipefail
#set -x

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

wait_for_command () {
  local COMMAND=$1
  local SLEEP_PERIOD_SECONDS=5

  until ${COMMAND} &> /dev/null
  do
    sleep ${SLEEP_PERIOD_SECONDS}
  done
}

echo "=== Installing and configuring ArgoCD ==="
oc apply -k bootstrap/
echo

echo "=== Waiting for Application CRD to exist ==="
wait_for_command "oc get crd applications.argoproj.io"
echo

echo "=== Waiting for openshift-gitops project to be created ==="
wait_for_command "oc get project openshift-gitops -o name"
echo

echo "=== Creating app-of-apps ==="
wait_for_command "oc get crd applications.argoproj.io"
oc apply -f ${SCRIPT_DIR}/argo-cd-apps/app-of-apps/minimal.yml
echo

echo "=== Waiting for ArgoCD UI to become available ==="
ARGOCD_ROUTE=https://$(oc get route openshift-gitops-server -n openshift-gitops -o jsonpath={.status.ingress[0].host})/
wait_for_command "curl -k ${ARGOCD_ROUTE}"
echo

echo === Done ===
echo
echo You can view the installed components in the ArgoCD UI at ${ARGOCD_ROUTE}

