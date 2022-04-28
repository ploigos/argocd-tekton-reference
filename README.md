# ArgoCD Tekton Reference Implementation

A reference implementation for using ArgoCD and Tekton together to implement gitops and deployment pipelines.

## Documentation
* [Getting Started Tutorial](https://ploigos.github.io/argocd-tekton-reference/) - A detailed introduction and setup instructions.
* [Local Development Environment Setup](https://github.com/ploigos/argocd-tekton-reference/blob/main/docs/Local_Dev_Environment.md) - Set up a local development environment using CodeReady Containers.

## Quick Setup
If you have done this sort of thing before and are using OpenShift, these instructions will get you up and running quickly. The [Getting Started Tutorial](https://ploigos.github.io/argocd-tekton-reference/) includes alternative setup instructions that use the web UI.
1. Install the OpenShift GitOps Operator and grant it RBAC permissions to install the remaining resources.
   * `oc create -k bootstrap/`
2. Wait for the operator to start ArgoCD. This may take a few minutes. You can monitor progress by looking at the Pods in the openshift-gitops project.
3. Install the "minimal" app-of-apps ArgoCD Application.
   * `oc create -f argo-cd-apps/app-of-apps/minimal.yml`

## Starting a Pipeline Manually Using the OpenShift Developer Console
You can use the OpenShift Developer Console to start the "easymode" pipeline with default options.

**Note:** If you are using CodeReady Workspaces, this will not work because the CRC installer does not create a StorageClass resource object by default. See below for CLI instructions that work with CRC.

To start the pipeline:
1. In the OpenShift developer console, expand the Pipelines menu option on the left navigation.
2. Pipelines -> easymode -> Actions -> Start
3. Under Workspaces, expand the dropdown for "shared-workspace" and select "VolumeClaimTemplate". 
4. Select Start.


## Starting a Pipeline Manually Using the Terminal
You can use the [tkn cli](https://github.com/tektoncd/cli) to start the "easymode" pipeline using the command line.
1. `oc project pipelines-easymode`
2. For convenience, you can run the script named [run-pipeline.sh](https://raw.githubusercontent.com/ploigos/argocd-tekton-reference/main/components/pipelines-as-a-service/easymode/run/run-pipeline.sh) in the `components/pipelines-as-a-service/easymode/run/` directory.
3. Or you can run the `tkn` command directly: 
   * You will need a template for creating a PersistentVolumeClaim. You can use [volume-claim-template.yml](https://raw.githubusercontent.com/ploigos/argocd-tekton-reference/main/components/pipelines-as-a-service/easymode/run/volume-claim-template.yml).
   * `tkn pipeline start easymode -w name=shared-workspace,volumeClaimTemplateFile=volume-claim-template.yml --use-param-defaults`
4. Watch the logs.
   * `tkn pipelinerun logs -f --last`
5. View a summary of the completed pipeline run.
   * `tkn pipelinerun describe --last`

## Triggering a Pipeline Run when your Application Changes
You can configure your source code repository to trigger a webhook and start the pipeline whenever your source code changes. These instructions assume you are using GitHub. The steps are very similar for most other services.
1. Fork the [example application](https://github.com/ploigos-reference-apps/pipelines-vote-api) on GitHub.
2. Configure your fork in  GitHub to start your Pipeline when the Application source code canges.
   * Settings -> Webhooks -> Add Webhook.
   * `Payload URL` - Enter the URL for the "easymode" EventListener Route that Tekton is listening on. You can get the correct value with `oc get route -n pipelines-easymode -o wide`.
   * `Content Type` - application/json
   * `SSL verification` - If your OpenShift cluster is using TLS certificates that GitHub does not trust, you will have to select SSL verification -> Disable. To avoid this when using github.com, you have to configure OpenShift with TLS certs signed by a well known certificate authority.
3. If you use the Test button on the GitHub settings page, the test will pass but the pipeline will not start. This is because the webhook event that GitHub uses to test does not contain all of the same information as real events.
4. To test the webhook configuration, make a change to your application source code. Commit and push the change.
5. Watch the pipeline run in the OpenShift developer console
   * Pipelines (left navigation menu item) -> Pipelines

## Triggering an ArgoCD Sync when your GitOps Repo Changes
You can configure your source code repository to trigger a webhook and cause ArgoCD to sync whenever your gitops code (i.e. the contents of this repository) changes. These instructions assume you are using GitHub. The steps are very similar for most other services.
1. Fork this git repository.
2. Edit the files under `argo-cd-apps` directory that contain the URL of this repository. Update the URL to refer to your fork. You can use your favorite IDE to do a find and replace on the URL.
3. Commit and push the edits to those files.
4. Browse to your GitHub repository.
5. Settings -> Webhooks -> Add Webhook
6. Enter these values
   * `Payload URL` - Enter the *ArgoCD* webhook URL for your cluster. This is *NOT* the Tekton EventListener webhook URL. You can get the first part of the value with `echo "https://$(oc get route openshift-gitops-server -n openshift-gitops -o jsonpath --template='{.spec.host}')/api/webhook"`. The URL will look like https://openshift-gitops-server-openshift-gitops.[your.cluster.com]/api/webhook
   * `Content Type` - application/json
   * `SSL verification` - If your OpenShift cluster is using TLS certificates that GitHub does not trust, you will have to select SSL verification -> Disable. To avoid this when using github.com, you have to configure OpenShift with TLS certs signed by a well known certificate authority.
7. Select "Add webhook".

## Example Pipelines
The quickstart includes several examples of pipelines.
Each one is in a directory under `components/pipelines-as-a-service/`.

* **easy-mode** - Start here. It demonstrates the basics and works great for *non-production* proof of concepts, including demonstrations of onboarding new workloads.
* **minimal** - Implements the Ploigos "minimal" standard workflow.

## Vault Integration
If you install the everything overlay, [Hashicorp Vault](https://github.com/hashicorp/vault) will be deployed into the `vault` namespace. With a fresh deployment, Vault will initialize and unseal itself, with the unseal key(s) and initial root token stored in the following file on persistent storage: `/vault/data/init.log`. Ensure that the credentials are recorded externally and this file is deleted for additional security.

The `Route` created by ArgoCD has a hardcoded host value that needs to be updated per cluster in this file: `argo-cd-apps/base/vault/vault.yml`
