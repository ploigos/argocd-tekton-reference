# EasyMode Example Application

## What is in this directory?
This is the fastest way to get an application building and deploying to  OpenShift using OpenShift Pipelines and OpenShift GitOps.

**IMPORTANT:** EasyMode is easy, but it has some limitations. The [Limitations](#Limitations) section has a list.
*Only use it in production **if** you are comfortable with those limitations.*
That said, it works great as a proof of concept or learning exercise.

## Setup
After you set up the quickstart repo (this git repo), the kubernetes resources (deployment, route, etc.) will be
deployed to OpenShift. The Pod will not start yet because the image has not been built yet. This is normal.
The pod will start as soon as you [run the pipeline manually](##Running the Pipeline Manually),
or configure a web hook in the application repo and trigger it.

## Running the Pipeline Manually
Use `./run/run-pipeline.sh` to start the pipeline without configuring a webhook in your git repository.

## Limitations

EasyMode is easy, but it has some limitations. *Only use it in production **if** you are comfortable with those limitations.*
That said, it works great as a proof of concept or learning exercise.

**TODO:** these are out of date since we moved to the update_deployment_task.

1. The application-specific kubernetes manifests are versioned in the same git repository that controls the infrastructure.
2. The application image is tagged :latest, and new deployments are done with an "oc rollout" command.
3. The application build (source compilation etc.) is done during the container build step.
4. The application has its own pipeline definition. The definition is not reusable without copy-pasting it.
5. By default, the pipeline only builds one source branch (main), and only deploys one instance of the application. There is no automatic deployment of feature branches. You **CAN** build and deploy new branches by creating copies of this directory and changing the event listener parameters to specify a different branch and image tag.
6. There is no automatic promotion from a staging environment to a production environment. You **CAN** create additional environments by adding new directories with k8s resource files and its own kustomization.yml, and then promote to them manually by editing the Deployment manifest (app-deployment.yml) to specify specifying an image tag or SHA for the version of the image you want to deploy, and then committing and pushing that change.
7. There are no "gates", including security scans, acceptance tests, or manual gates.
8. There are no automatic rollbacks if something goes wrong with the deployment.
9. ArgoCD deploys the :latest tag, and the specific image that tag points to changes.
10. Because of #9, the GitOps repository (this repository) does not fully describe the exact version of the app to be deployed in a way that is always reproducable. If you add additional environments and manually tag the deployed image as described in #6, those environments will be fully described by the GitOps definitions.
11. The only way to roll back automatic deployments is to re-run the pipeline after reverting a code change. Manual deployments to higher environments can be rolled back by editing the tag specified in app-deployment.yml.

## Using this to Onboard a New Workload
You can also use this as a template for onboarding a new application. To do that
1. Copy and rename this entire directory (easymode) to a new location *under* the components directory. Name it after your new application.
2. Go through the .yml files and rename identifiers to match the new application name.
3. Update the fields in eventlistener.yml under `params:` to meet the requirements of your application. 
   There are descriptions of each parameter in pipeline.yml to help you understand what the new value 
   should be. At a minimum you should change:
   1. `appRepoUrl` - the URL for the git repository that contains your application source code
   2. `appImage` - the name of the application image for your new app. Make sure this matches the image used in 
   app-deployment.yml.
4. You may also have to adjust the app-* resources in other ways to fit the requirements of your new application.
   for example, if your container exposes a port other than 8080, you should adjust the port number in app-svc.yml.
5. (Optional) Update the settings in your application git repo to add a webhook that triggers the build.
   See the main README at the root of this repo for instructions on that.

## Tutorial
This example application is loosely based on 
[this tutorial](https://docs.openshift.com/container-platform/4.9/cicd/pipelines/creating-applications-with-cicd-pipelines.html#assembling-a-pipeline_creating-applications-with-cicd-pipelines) in the OpenShift documentation.
The tutorial demonstrates how to build something similar from scratch.
