# OpenShift Pipelines Quickstart

A quickstart to get you up and running quickly with Red Hat OpenShift Pipelines and Red Hat OpenShift GitOps.

## Getting Started
1. (Optional) Set up your [local development environment](./docs/Local_Dev_Environment.md) using CRC
2. Install OpenShift GitOps and create the relevant RBAC resources.
   * `oc create -k bootstrap/`
3. Wait for the OpenShift operator to be installed and start ArgoCD. This may take a few minutes,
   depending on your cluster. Wait until you are able to browse to the ArgoCD landing page and log in successfully.
4. Install *ONLY ONE* of the "app-of-apps" ArgoCD Applications:
   * To install everything: `oc create -f argo-cd-apps/app-of-apps/everything.yml`
   * -OR- To install only the minimum components: `oc create -f argo-cd-apps/app-of-apps/minimal.yml`
5. The "app-of-apps" Application will create other Applications, which will create some or all of the resources in the
   'components/' directory.
6. (Optional) If you installed the `minimum` app-of-apps, you can now choose to install other applications à la carte.
   * Example: `oc create -k argo-cd-apps/base/third-party-services/sonarqube/` will install SonarQube.
   * Example: `oc create -k argo-cd-apps/base/example-apps/java-maven-cd/` will install an example pipeline that deploys a java application.
7. Look at all the stuff you installed! Browse to https://openshift-gitops-server-openshift-gitops.<<<your.cluster.com>>>/ or use the
   menu option at the top of the OpenShift web console to open the ArgoCD console.
8. Try building an [example application](https://github.com/ploigos-reference-apps/pipelines-vote-api) by manually running the 'easy-mode' pipeline - `oc create -f ./test/pipelineruns/easymode-vote-app-api.yml`
9. Monitor the progress of the pipeline run in the OpenShift development web console at Pipelines -> PipelineRuns, or with the cli command `tkn pipelinerun describe --last` 
10. View the the newly deployed application. Browse to the URL returned by `oc get route -o wide -n pipelines-easymode`.
11. Follow the next section to start the pipeline automatically when the application source code changes. To get started, can fork the [example application](https://github.com/ploigos-reference-apps/pipelines-vote-api) and edit the settings of your fork.

## Configuring GitHub to start your Pipeline when the Application Source Code Changes
In the GitHub repository for your application, go to Settings -> Webhooks -> Add Webhook.
* `Payload URL` - Enter the Tekton *EventListener* webhook URL for your cluster. This is *NOT* the ArgoCD webhook URL. You can get the correct value with `oc get route -n pipelines-easymode -o wide`. The URL should look like https://easymode-pipelines-easymode.[your.cluster.com]/
* `Content Type` - application/json
* `SSL verification` - If your OpenShift cluster is using TLS certificates that GitHub does not trust, you will have to select SSL verification -> Disable. To avoid this when using github.com, you have to configure OpenShift with TLS certs signed by a well known certificate authority. 

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
