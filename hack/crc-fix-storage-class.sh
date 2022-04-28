set -eux -o pipefail

HACK_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Create a default StorageClass
oc create -f ${HACK_DIR}/default-storageclass.yml

# Associate all existing PersistentVolumes with the default StorageClass
for p in $(oc get pv -o name); do oc patch $p -p '{"spec": {"storageClassName": "default"}}'; done

