#!/bin/sh
# oc label node <NodeName> cluster.ocs.openshift.io/openshift-storage=''
oc label node storage-0 cluster.ocs.openshift.io/openshift-storage=''
oc label node storage-1 cluster.ocs.openshift.io/openshift-storage=''
oc label node storage-2 cluster.ocs.openshift.io/openshift-storage=''

# Local Storage
oc apply -f manifests/openshift-local-storage-namespace.yaml
oc apply -f manifests/local-operator-group.yaml
oc apply -f manifests/local-storage-subscription.yaml
#Wait for CRD registration
sleep 120
oc apply -f manifests/localvolume-block.yaml

# OCS
oc apply -f manifests/openshift-storage-namespace.yaml
oc apply -f manifests/openshift-storage-operatorgroup.yaml
oc apply -f manifests/openshift-storage-subscription.yaml
#Wait for CRD registration
sleep 120
oc apply -f manifests/ocs-storagecluster.yaml



