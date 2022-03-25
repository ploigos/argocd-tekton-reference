# ArgoCD Tekton Reference Implementation

A reference implementation for using ArgoCD and Tekton together to implement gitops and deployment pipelines.

## Documentation
* [Getting Started Tutorial](https://ploigos.github.io/argocd-tekton-reference/) - A detailed introduction and setup instructions.
* [Local Development Environment Setup](https://github.com/ploigos/argocd-tekton-reference/blob/main/docs/Local_Dev_Environment.md) - Set up a local development environment using CodeReady Containers.

## Quick Setup
These instructions assume you are installing in OpenShift and want to use the CLI. The [Getting Started Tutorial](https://ploigos.github.io/argocd-tekton-reference/) has alternate setup instructions that use the web consoles.
1. Install the OpenShift GitOps Operator and grant it RBAC permissions to install the remaining resources.
   * `oc create -k bootstrap/`
2. Wait for the operator to start ArgoCD. This may take a few minutes. You can monitor progress by looking at the Pods in the openshift-gitops project.
3. Install the "everything" ArgoCD Application.
   * `oc create -f argo-cd-apps/app-of-apps/everything.yml`
4. Fork the [example application](https://github.com/ploigos-reference-apps/pipelines-vote-api) on GitHub.
5. Configure your fork in  GitHub to start your Pipeline when the Application source code canges.
   * Settings -> Webhooks -> Add Webhook.
   * `Payload URL` - Enter the URL for the "easymode" EventListener Route that Tekton is listening on. You can get the correct value with `oc get route -n pipelines-easymode -o wide`.
   * `Content Type` - application/json
   * `SSL verification` - If your OpenShift cluster is using TLS certificates that GitHub does not trust, you will have to select SSL verification -> Disable. To avoid this when using github.com, you have to configure OpenShift with TLS certs signed by a well known certificate authority.
6. Watch the pipeline run!
   * In the OpenShift console, Pipelines (left navigation) -> Pipelines 

## (Optional) Triggering an ArgoCD Sync when your GitOps Repo Changes
In your fork of this quickstart repository go to Settings -> Webhooks -> Add Webhook.
* `Payload URL` - Enter the *ArgoCD* webhook URL for your cluster. This is *NOT* the Tekton EventListener webhook URL. You can get the first part of the value with `echo "https://$(oc get route openshift-gitops-server -n openshift-gitops -o jsonpath --template='{.spec.host}')/api/webhook"`. The URL should look like https://openshift-gitops-server-openshift-gitops.[your.cluster.com]/api/webhook
* `Content Type` - application/json
* `SSL verification` - If your OpenShift cluster is using TLS certificates that GitHub does not trust, you will have to select SSL verification -> Disable. To avoid this when using github.com, you have to configure OpenShift with TLS certs signed by a well known certificate authority.

## Example Pipelines
The quickstart includes several examples of pipelines.
Each one is in a directory under `components/pipelines-as-a-service/`.

* **easy-mode** - Start here. It demonstrates the basics and works great for *non-production* proof of concepts, including demonstrations of onboarding new workloads.
* **minimal** - Implements the Ploigos "minimal" standard workflow.
