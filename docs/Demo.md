# Demo Overview
 
This document explains how to demonstrate the setup and features of this quickstart using primarily web UIs.
 
The [README](../README.md) has instructions for getting started quickly and repeatably with the CLI. This guide uses
web UIs to help an audience quickly understand with minimal background.
 
You will need an OpenShift cluster for the Demo. It must be able to install the GitOps and Pipelines Operators from the Red Hat Marketplace.
See [the local dev environment instructions](Local_Dev_Environment.md) if you want to set that up on your local machine.
 
## Important Constructs - Day 0, 1, 2
 
The day 0, 1, and 2 concepts are critical to understanding the operations of any software system. Within the context of Ploigos, the following is how we define Day 1, 2, and 3. We used a [DZone Day-2 Operations Article][/dzone.com/articles/defining-day-2-operations] as inspiration:
 
* **Day 0** - The first phase of any software system consists of requirements engineering, design, and architecture.
 * Ploigos provides a Day 0 opinion provides 100% design solution for getting started.
 * This opinion provides a pre-designed & architected solution with extension points.
 * This Day 0 can be found one the [Ploigos Workflows](https://ploigos.github.io/ploigos-docs/#_cicd_process_workflow).
 * This design distills the most common concepts for differing integration and deployment approach.
* **Day 1** - Installation, setup, and configuration of the system
 * The installation, setup, and configuration of the tooling is handled via the (Argo CD Apps)[../argo-cd-apps/app-of-apps].
 * We  use an App of Apps approach where we delcare all required applications for a given workflow, then use Argo to manage the installation and confiugration.
 * This is a true (GitOps)[https://www.redhat.com/en/topics/devops/what-is-gitops] approach to managing a software delivery platform.
* **Day 2** - Continuous Operations of the system.  Such as peroidc tasks (houlry, daily, weekly, monthly, etc..), maintenance, and optimization
 * Onboarding new applications
 * Adding pipelines for new application archetypes
 
 
# Demo Execution - Day 0, 1, 2
 
This demo walks you through getting-to-day-two within minutes.  The Day 0 design is povided via the [Ploigos Workflows](https://ploigos.github.io/ploigos-docs/#_cicd_process_workflow) and the [Ploigos Workflow Tools](https://ploigos.github.io/ploigos-docs/#ploigos-workflow-tools).
 
This demo will implement the [Minimal Workflow](https://ploigos.github.io/ploigos-docs/#_minimum_workflow).
 
## Forking Requirments
 
You need to fork the following repositories to be successful with this demo.  If you have a lot of existing repositories, it may be easiers to temporarily [create a new GitHub Organization](https://docs.githubeasier/organizations/collaborating-with-groups-in-organizations/creating-a-new-organization-from-scratch) to store the forks.
 
* [OpenShift Pipelines Quickstart](https://github.com/ploigos/openshift-pipelines-quickstart)
* [Pipelines Vote API](https://github.com/ploigos-reference-apps/pipelines-vote-api)
* [Pipelines Vote UI](https://github.com/ploigos-reference-apps/pipelines-vote-ui)
 
---
 
***NOTE - March 14, 2022***
 
We are amid porting logic from the Ploigos Step Runner into this new Tekton-native implementation.  This port is removing the dependency upon the step runner.  This new tekton native implementation does not have the following workflow steps completed:
 
 * Setup
   * Setup Workflow Step Runner
   * Setup Encrypted Configuration Decryption
 * Continuous Integration
   * Generate Metadata
 
---
 
## Day 1 - Installation, Setup, and Configuration
 
## Overview
 
TODO - Describe how Ago listens to the app of apps and rectifies the tools
 
### First, Install the OpenShift GitOps Operator
 
1. Open the OpenShift Admin Console.
  1. If you are using CRC, the URL is https://console-openshift-console.apps-crc.testing/
  2. log in as a user with ClusterAdmin. If you use CRC, the user is `kubeadmin` and gets the password with `CRC console --credentials.`
2. Install the GitOps operator.
  1. Operators -> Operator Hub -> Search "gitops" -> Choose "Red Hat OpenShift GitOps" -> Install
  2. Use the default options
  3. Select "Install"
3. View the installed Operator ... **TODO**
4. Create RBAC objects for ArgoCD
   1. Click the (+) icon at the top of the Admin Console to create a resource.
   2. Copy and paste the contents of [openshift-gitops-clusterroles.yml](../bootstrap/openshift-gitops-clusterroles.yml).
   3. Select "Create"
   4. (This allows ArgoCD to create operators and **disallows the user from making manual changes using the ArgoCD UI**.)
5. Open the ArgoCD web UI
   1. Click the grid icon at the top of the Admin UI and select the link for the ArgoCD console.
   2. If the UI does not show up yet, wait for a few minutes and refresh your browser.
   3. "LOGIN VIA OpenShift"
   4. Use `kubeadmin` as the user and the same password you used to log in to the OpenShift Admin Console.
   5. If prompted with a screen that says "Authorize Access" Select "Allow Selected permissions"
 
### Second, Create the app-of-apps ArgoCD Application
 
The quickstart uses ArgoCD (installed by the Red Hat Gitops Operator) to install the following:
 
Tekton tasks, sample applications, etc. To start the rest of the installation, create an ArgoCD-specific custom resource
specifying what to install.
 
1. Open the OpenShift Admin Console
2. Create the ArgoCD Application CR
  1. Click the (+) icon at the top of the OpenShift Admin Console to create a resource.
  2. Copy and paste the contents of [everything.yml](../argo-cd-apps/app-of-apps/everything.yml).
3. Open the ArgoCD console to verify that the app-of-apps application and dependent applications were created.
4. Open the "Installed Operators" view in the OpenShift Admin Console to verify that OpenShift Pipelines Operator was installed.
 
 
## Day 2 - Daily Operations
 
### Overview
 
This demo focus on providing an x-as-a-service model for software delivery.  This is achieved by providing a REST endpoint for each application archetype.  This endpoint is consumed as a webook via a GitRepo and triggered via a push to some branch.
 
It does not matter if:
* The output artifact is a runtime (Quarkus) or a simple shared library.
 
The following are possible application archetypes
* Java Maven - A Java-based application that uses the Maven build, test, and package tool. 
* Java Gradle - A Java-based application uses the Gradle build, test, and package tool.
* JavaScript NPM - A JavaScript application that uses the Node Package Manager (NPM) as the interface for the build, test, and package tool(s).
 
***
 
#### What is an Application Archetype?
 
An ***Application Archetype*** refers to the programming language and building a mechanism for a given software project. 
 
***
 
### First, Setup A New Pipeline as a Service
 
1. Start the easy-mode pipeline
  1. **TODO**
 

