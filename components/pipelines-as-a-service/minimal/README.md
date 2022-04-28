# Onboarding an Example Application from GitHub

## Assumptions
* The application you are building is hosted on github.com.
* The base image for your application is hosted on registry.redhat.io.

## Prerequisites
* The the [GitHub CLI](https://cli.github.com/) is installed.
  * To install `gh` using `dnf`:
  ```shell
  sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
  sudo dnf install gh
  ```
* A GitHub user for the pipeline to authenticate as.
* Access to add an ssh key for the GitHub user.
* Credentials for registry.redhat.io.

## Setup
* Install the Openshift GitOps Operator, which will install ArgoCD.
  * `oc create -k bootstrap/`
* Wait for the operator to start ArgoCD. This may take a few minutes. You can monitor progress by looking at the Pods in the openshift-gitops project.
* Install the Pipeline as a Service minimal overlay.
  * `oc create -f argo-cd-apps/app-of-apps/minimal.yml`
* Create a docker pull secret to allow the pipeline to pull the base image from registry.redhat.com
```shell
  podman login registry.redhat.io
  PIPELINES_NAMESPACE=pipelines-minimal # ArgoCD creates this namespace. Change it here if you customized the deployment.
  oc create secret generic docker-redhat-auth --from-file=.dockerconfigjson=${XDG_RUNTIME_DIR}/containers/auth.json -n ${PIPELINES_NAMESPACE} # If your podman install places auth.json somewhere else (unlikely) then you may have to change the path
  oc secret link pipeline docker-redhat-auth -n ${PIPELINES_NAMESPACE} --for=pull
```
* Configure SSH authentication for the pipeline's GitHub user
```shell
  # Generate a new private/public key pair for the pipeline to use to authenticate with github
  ssh-keygen -f pipeline_rsa -N ''
  
  # Create a secret to store the private key and then delete the private key file
  PIPELINES_NAMESPACE=pipelines-minimal # ArgoCD creates this namespace. Change it here if you customized the deployment.
  oc create secret generic github-auth --type=kubernetes.io/ssh-auth --from-file=ssh-privatekey=pipeline_rsa -n ${PIPELINES_NAMESPACE}
  oc patch secret github-auth -p '{"metadata":{"annotations":{"tekton-dev/git-0":"github.com"}}}' -n ${PIPELINES_NAMESPACE}
  oc secret link pipeline github-auth -n ${PIPELINES_NAMESPACE}
  rm pipeline_rsa

  # Upload public key to GitHub and then delete the public key file
  gh auth login -s admin:public_key -h github.com
  gh ssh-key add -t "Tekton pipeline access" pipeline_rsa.pub
  rm pipeline_rsa.pub
```

## Onboarding
* Create webhooks - https://stackoverflow.com/questions/69478970/how-to-create-a-webhook-from-curl-or-github-cli
