# Setting up a Local Development Environment

You can use [Red Hat CodeReady Containers](https://developers.redhat.com/products/codeready-containers/overview) (CRC) to set up a local development environment suitable for running this quickstart.

## About CodeReady Containers

[Red Hat CodeReady Containers](https://developers.redhat.com/products/codeready-containers/overview) (CRC) is the quickest way to get started building OpenShift clusters. It is designed to run on a local computer to simplify setup and testing, and emulate the cloud development environment locally with all of the tools needed to develop container-based applications.

## Prerequisites
* A [Red Hat Developer](https://developers.redhat.com/about) account.
* Hardware - at least 8 cpu cores and 32 GiB RAM.

# Instructions

1. [Install CRC](https://developers.redhat.com/download-manager/link/3868678)
2. **Do step this BEFORE you run crc start**. Configure CRC with enough resources to run the quickstart:
   1. `crc config set memory 24576`
   2. `crc config set cpus 7`
3. `crc start`
4. Login to OpenShift as kubeadmin using the `oc` cli. Refer to the output of `crc console --credentials`
5. Run `crc console` to open the OpenShift web console.
6. Login to the web console as kubeadmin (see the `crc console --credentials` output for the password).
7. You can now proceed with the [Getting Started section of the quickstart README](../README.md#Getting Started).
