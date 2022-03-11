# Setup and Usage Demo

This document explains how to demonstrate the setup and features of this quickstart using primarily web UIs.


The [README](../README.md) has instructions for getting started quickly and repeatably with the CLI. This guide uses
web UIs to help an audience quickly understanding with minmal background.

You will need an OpenShift cluster for the Demo. It must be able to install the GitOps and Pipelines Operators from the Red Hat Marketplace. 
See [the local dev environment instructions](Local_Dev_Environment.md) if you want to set that up on your local machine.

# Setup

## Install the OpenShift GitOps Operator
1. Open the OpenShift Admin Console.
   1. If you are using CRC, the URL is https://console-openshift-console.apps-crc.testing/
   2. Login as a user with ClusterAdmin. If you are using CRC, the user is `kubeadmin` and get the password with `crc console --credentials`
2. Install the GitOps operator.
   1. Operators -> Operator Hub -> Search "gitops" -> Choose "Red Hat OpenShift GitOps" -> Install
   2. Use the default options
   3. Select "Install"
3. Create RBAC objects for ArgoCD
    1. Click the (+) icon at the top of the Admin Console to create a resource.
    2. Copy and paste the contents of [openshift-gitops-clusterroles.yml](../bootstrap/openshift-gitops-clusterroles.yml).
    3. Select "Create"
    4. (This allows ArgoCD to create operators and **disallows the user from making manual changes using the ArgoCD UI**.)
4. Open the ArgoCD web UI
    1. Click the grid icon at the top of the Admin UI and select the link for the ArgoCD console.
    2. If the UI does not show up yet, wait for a few minutes and refresh your browser.
    3. "LOGIN VIA OpenShift"
    4. Use `kubeadmin` as the user and the same password you used to login to the OpenShift Admin Console.
    5. If prompted with a screen that says "Authorize Access" Select "Allow Selected permissions".

## Create the app-of-apps ArgoCD Application
The quickstart uses ArgoCD (installed by the Red Hat Gitops Operator) to install everything else that is included:
Tekton tasks, example applications, etc. To start the rest of the install, create an ArgoCD-specific custom resource
specifying what to install.
1. Open the OpenShift Admin Console
2. Create the ArgoCD Application CR
   1. Click the (+) icon at the top of the Admin Console to create a resource.
   2. Copy and paste the contents of [everything.yml](../argo-cd-apps/app-of-apps/everything.yml).

# Run a Pipeline
6. Start the easymode pipeline
   1. **TODO**
