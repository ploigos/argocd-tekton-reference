oc get taskrun | grep -v NAME | cut -d ' ' -f 1 | xargs oc delete taskrun
oc get task | grep -v NAME | cut -d ' ' -f 1 | xargs oc delete task
oc get pipeline | grep -v NAME | cut -d ' ' -f 1 | xargs oc delete pipeline
oc get pipelinerun | grep -v NAME | cut -d ' ' -f 1 | xargs oc delete pipelinerun
oc get pvc | grep -v NAME | cut -d ' ' -f 1 | xargs oc delete pvc

