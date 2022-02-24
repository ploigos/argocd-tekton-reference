# Ploigos Quickstart

A quickstart to get you up and running quickly with Red Hat OpenShift Pipelines and Red Hat OpenShift GitOps.

## Getting Started
1. Install OpenShift GitOps and configure relevant RBAC settings.
   * `oc create -k bootstrap/openshift-gitops/`
2. Wait for the OpenShift operator to be installed and start ArgoCD. This may take a few minutes,
   depending on your cluster. Wait until you are able to browse to the ArgoCD landing page and log in successfully.
3. From this point on, everything is installed by creating on one or more ArgoCD Applications.
   These Applications configure OpenShift GitOps to deploy resource manifests placed in the `components/` directory.
4. Install the minimum additional requirements to make the quickstart work.
   * `oc create -k bootstrap/core/`
   * This will install the OpenShift Pipelines Operator and some reusable Tekton custom resources (Pipelines and Tasks).
5. Install any extras that interest you, examples:
   * To install *all* of the extras - `oc create -k boostrap/extras/`
   * To install individual extras, use the -f switch and specify individual files in the bootstrap directory:
     * `oc create -f bootstrap/extras/example-apps/java-maven.yml`
     * `oc create -f bootstrap/extras/third-party-services/sonarqube.yml`
   * To install all extras in a subdirectory, use the -k switch and specify a subdirectory of `bootstrap/extras/`:
     * `oc create -k bootstrap/extras/third-party-services/`
