#!/bin/sh
set -ex

IMAGE_REGISTRY=quay.io
IMAGE_REGISTRY_USER=dwinchell_redhat
IMAGE_TAG=latest

# Build pipeline bundles
for YAML_FILE in $(ls resources/pipelines/*.yml); do
  TASK_NAME=$(basename ${YAML_FILE} | sed 's/\(.*\)\.yml/\1/')
  tkn bundle push ${IMAGE_REGISTRY}/${IMAGE_REGISTRY_USER}/${TASK_NAME}-bundle:${IMAGE_TAG} -f ${YAML_FILE}
done

# Build task bundles
for YAML_FILE in $(ls resources/tasks/*.yml); do
  TASK_NAME=$(basename ${YAML_FILE} | sed 's/\(.*\)\.yml/\1/')
  tkn bundle push ${IMAGE_REGISTRY}/${IMAGE_REGISTRY_USER}/${TASK_NAME}-task-bundle:${IMAGE_TAG} -f ${YAML_FILE}
done

