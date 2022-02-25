# Ploigos Quickstart

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
