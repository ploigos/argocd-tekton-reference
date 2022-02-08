# What is this directory?
This directory contains tasks downloaded from the Tekton Catalog. Some of them have been modified. Each yaml file is a task.

Each task in the catalog has a label in its yaml definition, `app.kubernetes.io/version`, that will tell you what version was downloaded to this directory. There are upgrade instructions below.

# License
All downloaded Tasks are subject to the Apache Licesnse version 2.0. Please see the LICENSE file in this directory for details.

# Tasks

## buildah
* Upstream version: 0.3
* Downloaded from: https://raw.githubusercontent.com/tektoncd/catalog/main/task/buildah/0.3/buildah.yaml
* Modifications: none

## maven
* Upstream version: 0.2
* Downloaded from: https://raw.githubusercontent.com/tektoncd/catalog/main/task/maven/0.2/maven.yaml
* Modifications: none

## sonarqube-scanner
* Upstream version: 0.1
* Downloaded from: https://raw.githubusercontent.com/tektoncd/catalog/main/task/sonarqube-scanner/0.1/sonarqube-scanner.yaml
* Modifications
  * Added a sed command to redact the sonar.password when the Task cats out sonar-project.properties

## yq
* Upstream version: 0.3
* https://raw.githubusercontent.com/tektoncd/catalog/blob/main/task/yq/0.3/yq.yaml
* Modifications: none

# How To
## Add a New Task from the Catalog
* Download the yaml for the new version from https://github.com/tektoncd/catalog/.
* Place the file in this directory.

# Modify the Code of a Task from the Catalog
* Be aware that if you upgrade the task to a new version published in the catalog, you will have to make the modifications again.
* Update the yaml file for the task in this directory.
* Note the change in this file.

# Upgrade a Task from the Catalog
* (If there were code modifications) Check what was modified - download the old version of the task and diff it against what is in this directory.
* Download the yaml for the new version from https://github.com/tektoncd/catalog/.
* Replace the yaml in this directory with the downloaded version.
* (If there were code modifications) You have to make them again. Look at the diff from Step 1 to help with this.
* (If there were code modifications) Consider contributing the modifications upstream, so that you don't have to make the changes again every time you upgrade the task.
* Update this file with the new version and URL
