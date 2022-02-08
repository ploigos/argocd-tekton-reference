#!/bin/sh
set -ex

IMAGE_REGISTRY=quay.io
IMAGE_REGISTRY_USER=dwinchell_redhat
IMAGE_TAG=latest

# Create pvcs
oc apply -f pvcs.yaml

# Build pipeline bundles
oc apply -f resources/pipelines/ci-java.yml
oc apply -f resources/pipelines/everything-java.yml

# Build task bundles
for YAML_FILE in $(ls resources/tasks/*.yml); do
  TASK_NAME=$(basename ${YAML_FILE} | sed 's/\(.*\)\.yml/\1/')
  oc apply -f ${YAML_FILE}
done

# Install third party tasks
./install-third-party.sh
