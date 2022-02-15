#### THIS IS A WORK IN PROGRESS. IT WON'T WORK IF YOU RUN IT DIRECTLY. ####
# That is because because the taks will execute in parallel. But, you can copy paste the create commands."
# Work is planned to script waiting for the tasks to complete.
set +ex
./cleanup.sh 
./install.sh
oc create -f taskruns/ploigos-git-clone.yml 
oc get taskrun package-application-dvjws -o yaml | yq .status.conditions[].reason
oc create -f taskruns/package-application.yml 
oc create -f taskruns/create-container-image.yml 
oc create -f taskruns/push-container-image.yml 

def create_task() {
    oc create -f taskruns/${1}.yml
}

def wait_on_task() {
  while 
}
