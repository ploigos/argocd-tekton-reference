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
8. Try running a pipeline manually - `oc create -f ./test/pipelineruns/poc-starter.yml`
9. Monitor the progress of the pipeline run in the OpenShift development web console at Pipelines -> PipelineRuns, or with the cli command `tkn pipelinerun describe --last` 
10. Check out the newly built application - **TODO LINK**

## What is Included?

### Example Apps

The quickstart includes several examples of how to use the technology stack to build and deploy user facing applications.
Each one is in a directory under `components/example-apps/`.

* **easy-mode** - Start here. It demonstrates the basics and works great for *non-production* proof of concepts, including demonstrations of onboarding new workloads.
* **advanced-mode** - **COMING SOON** -  When you need more than easy-mode, use this.
* **reusable-pipeline** - **COMING SOON** - Shows how to use Tekton Bundles to reuse the same pipeline definition for multiple workloads.
* **sonarqube-scan** - **COMING SOON** - Shows how to add a code quality scan to a pipeline using SonarQube. Requires sonarqube to be installed. See `third-party-services/sonarqube/`.

### Third Party Services
**TODO**

### Third Party Tasks
**TODO**

## Using Example Applications as Templates
The example applications can be used as templates to onboard new applications to OpenShift. In some cases this is as easy as copying a directory and making a few simple edits.
The README for each example application has instructions for this.

### Forking this Git Repo
**TODO**

#### (Optional) Triggering an ArgoCD Sync when the GitOps Repo Changes
If your fork is on GitHub, go to Settings -> Webhooks -> Add Webhook.
* `Payload URL` - Enter the *ArgoCD* webhook URL for your cluster. This is *NOT* the Tekton EventListener webhook URL. You can get the correct value with `oc get route openshift-gitops-server -n openshift-gitops -o wide`. The URL should look like https://openshift-gitops-server-openshift-gitops.[your.cluster.com]/api/webhook
* `Content Type` - application/json
* `SSL verification` - If your OpenShift cluster is using TLS certificates that GitHub does not trust, you will have to select SSL verification -> Disable. To avoid this when using github.com, you have to configure OpenShift with TLS certs signed by a well known certificate authority.

### Forking the Example Application
The poc-starter example builds https://github.com/dwinchell/quarkus-quickstarts.git. You might want to fork that repository in order to set up webhooks or hack on the application code. In GitHub, you can follow that link and then use the "Fork" button at the top of the page.
Then edit `components/example-apps/poc-starter/eventlistener.yml`. Commit that change and push it to your fork of the `openshift-pipelines-quickstart` repo. After that, the pipeline will clone and build your fork of the application code.

#### (Optional) Triggering Pipeline Runs when the Application Code Changes
If your fork is on GitHub, go to Settings -> Webhooks -> Add Webhook.
* `Payload URL` - Enter the Tekton *EventListener* webhook URL for your cluster. This is *NOT* the ArgoCD webhook URL. You can get the correct value with `oc get route -n quickstart-poc-starter -o wide`. The URL should look like https://quickstart-poc-starter-el-quickstart-poc-starter.[your.cluster.com]/
* `Content Type` - application/json
* `SSL verification` - If your OpenShift cluster is using TLS certificates that GitHub does not trust, you will have to select SSL verification -> Disable. To avoid this when using github.com, you have to configure OpenShift with TLS certs signed by a well known certificate authority. 
