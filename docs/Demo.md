# Setup and Usage Demo

This document explains how to demonstrate the setup and features of this quickstart using primarily web UIs.


The [README](../README.md) has instructions for getting started quickly and repeatably with the CLI. This guide uses
web UIs to help an audience quickly understanding with minmal background.

You will need an OpenShift cluster for the Demo. It must be able to install the GitOps and Pipelines Operators from the Red Hat Marketplace. 
See [the local dev environment instructions](Local_Dev_Environment.md) if you want to set that up on your local machine.

# Setup
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
    3. This allows ArgoCD to create operators and **disallows the user from making manual changes using the ArgoCD UI**.
4. Open the ArgoCD web UI
   1. Wait for the GitOps operator to install and start its workload. This may take a few minutes. You can monitor the 
      progress of 1) the operator in the Operator Hub screen, and then 2) the pod deployments in the openshift-gitops project.
   2. Click the grid icon at the top of the Admin UI and select the link for the ArgoCD console.
5. Create the ArgoCD Application CR that deploys everything else.
   1. Click the (+) icon at the top of the Admin Console to create a resource.
   2. Copy and paste the contents of [everything.yml](../app-of-apps/everything.yml).
6. Start the easymode pipeline
   1. **TODO**
