This repository contains (Tekton Bundles)[https://github.com/tektoncd/community/blob/main/teps/0005-tekton-oci-bundles.md] for Ploigos based Pipelines and Tasks.

# Prerequisites
* OpenShift
* OpenShift GitOps operator
* sops cli
* If installing the demo that uses authenticated services, your pgp key added to the encrypted secrets in the infra/ directory

# Setup
./create-secrets.sh
./install.sh

