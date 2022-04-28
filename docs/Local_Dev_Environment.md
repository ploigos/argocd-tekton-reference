# Setting up a Local Development Environment

You can use [Red Hat CodeReady Containers](https://developers.redhat.com/products/codeready-containers/overview) (CRC) to set up a local development environment suitable for running this quickstart.

## About CodeReady Containers

[Red Hat CodeReady Containers](https://developers.redhat.com/products/codeready-containers/overview) (CRC) is the quickest way to get started building OpenShift clusters. It is designed to run on a local computer to simplify setup and testing, and emulate the cloud development environment locally with all of the tools needed to develop container-based applications.

## Prerequisites
* A [Red Hat Developer](https://developers.redhat.com/about) account.
* Hardware - at least 8 cpu cores and 32 GiB RAM.

# Instructions

1. [Install CRC](https://developers.redhat.com/download-manager/link/3868678)
2. `crc setup`
3. **Do step this BEFORE you run crc start**. Configure CRC with enough resources to run the quickstart:
   1. `crc config set memory 24576`
   2. `crc config set cpus 7`
4. `crc start` - This can take 10 minutes or more depending on your environment.
5. Login to OpenShift as kubeadmin using the `oc` cli. Refer to the output of `crc console --credentials`
6. (Optional) Follow the instructions in the section below to create a default StorageClass.
7. Run `crc console` to open the OpenShift web console.
8. Login to the web console as kubeadmin (see the `crc console --credentials` output for the password).
9. You can now proceed with the [Getting Started section of the quickstart README](../README.md#Getting Started).

# Creating a Default Storage Class
A fresh installation of CodeReady Workspaces does not include any StorageClass resource objects. You can still create
PVs and PVCs, but any applications that look specifically for StorageClasses will not find them. This is a minor
problem for OpenShift Pipelines. Unless you fix it, any pipeline that you start manually from the Developer Console will
fail hang because the first Pod that uses a PersistentVolume will not start, because it has been assigned a StorageClass
that does not exist, because the console was not able to failed StorageClasses using the k8s API and defaulted to trying
one that does not exist in CRC.

To create a default StorageClass and fix the issue:
1. Clone this git repository.
   * `git clone https://github.com/ploigos/argocd-tekton-reference.git`
2. In the terminal, change directories to the root of the cloned repository.
   * `cd argocd-tekton-reference/`
3. Login to OpenShift as kubeadmin using the `oc` cli. Refer to the output of `crc console --credentials`
4. Create a StorageClass, with an annotation that makes it the default `oc create -f hack/default-storageclass.yml`
