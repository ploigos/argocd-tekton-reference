# Ploigos Quickstart

A quickstart to get you up and running quickly with Red Hat OpenShift Pipelines and Red Hat OpenShift GitOps.

## Getting Started

### Installation
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
8. Monitor the progress of the pipeine run in the OpenShift development web console at Pipelines -> PipelineRuns, or with the cli command `tkn pipelinerun describe --last` 
9. Check out the newly built application - **TODO LINK**

### Forking ths Git Repo
**TODO**

### Forking the Example Application Repo
**TODO**

## What is Included?
**TODO**

### Example Apps

The quickstart includes several examples of how to use the technology stack to build and deploy user facing applications.
Each one is in a directory under `components/example-apps/`.

* **poc-starter** - The easiest way to get started. When you want to onboard a workload to OpenShift and you are doing a proof of concept, start here.
* **production-starter** - **COMING SOON** -  When you want to onboard an application to OpenShift and it has to be production-ready or will be actively maintained by a development team, start here.
* **reusable-pipeline** - Shows how to use Tekton Bundles to reuse the same pipeline definition for multiple workloads.
* **sonarqube-scan** - Shows how to add a code quality scan to a pipeline using SonarQube. Requires sonarqube to be installed. See third-party-services/sonarqube/.
