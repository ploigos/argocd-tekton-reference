# OpenShift Pipelines Quickstart

A quickstart to get you up and running quickly with Red Hat OpenShift Pipelines and Red Hat OpenShift GitOps.

## Getting Started
1. Install OpenShift GitOps and configure relevant RBAC settings.
   * `oc create -k bootstrap/`
2. Wait for the OpenShift operator to be installed and start ArgoCD. This may take a few minutes,
   depending on your cluster. Wait until you are able to browse to the ArgoCD landing page and log in successfully.
3. Install *ONLY ONE* of the "app-of-apps" ArgoCD Applications:
   * To install everything: `oc create -f argo-cd-apps/app-of-apps/everything.yml`
   * -OR- To install only the minimum components: `oc create -f argo-cd-apps/app-of-apps/minimal.yml`
4. The "app-of-apps" Application will create other Applications, which will create some or all of the resources in the
   'components/' directory.
5. (Optional) If you installed the `minimum` app-of-apps, you can now choose to install other applications à la carte.
   * Example: `oc create -k argo-cd-apps/base/third-party-services/sonarqube/` will install SonarQube.
   * Example: `oc create -k argo-cd-apps/base/example-apps/java-maven-cd/` will install an example pipeline that deploys a java application.
6. Look at all the stuff you installed! Browse to https://openshift-gitops-server-openshift-gitops.<<<your.cluster.com>>>/ or use the
   menu option at the top of the OpenShift web console to open the ArgoCD console.
7. Try running a pipeline manually - `oc create -f ./test/pipelineruns/poc-starter.yml`
8. Monitor the progress of the pipeline run in the OpenShift development web console at Pipelines -> PipelineRuns, or with the cli command `tkn pipelinerun describe --last` 
9. Check out the newly built application - **TODO LINK**

## What is Included?

### Example Apps

The quickstart includes several examples of how to use the technology stack to build and deploy user facing applications.
Each one is in a directory under `components/example-apps/`.

* **poc-starter** - The easiest way to get started. When you want to onboard a workload to OpenShift and you are doing a proof of concept, start here.
* **production-starter** - **COMING SOON** -  When you want to onboard an application to OpenShift and it has to be production-ready or will be actively maintained by a development team, start here.
* **reusable-pipeline** - **COMING SOON** - Shows how to use Tekton Bundles to reuse the same pipeline definition for multiple workloads.
* **sonarqube-scan** - **COMING SOON** - Shows how to add a code quality scan to a pipeline using SonarQube. Requires sonarqube to be installed. See `third-party-services/sonarqube/`.

### Third Party Services
**TODO**

### Third Party Tasks
**TODO**

## Customizing the Quickstart

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
