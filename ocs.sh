#!/bin/sh
# oc label node <NodeName> cluster.ocs.openshift.io/openshift-storage=''
oc label node storage-0 cluster.ocs.openshift.io/openshift-storage=''
oc label node storage-1 cluster.ocs.openshift.io/openshift-storage=''
oc label node storage-2 cluster.ocs.openshift.io/openshift-storage=''

# Local Storage
oc apply -f manifests/openshift-local-storage-namespace.yaml
oc apply -f manifests/local-operator-group.yaml
oc apply -f manifests/local-storage-subscription.yaml
# Poczekaj na stworzenie LocalVolume CRD
oc wait --for condition=established --timeout=60s crd/localvolumes.local.storage.openshift.io
oc apply -f manifests/localvolume-block.yaml

# OCS
oc apply -f manifests/openshift-storage-namespace.yaml
oc apply -f manifests/openshift-storage-operatorgroup.yaml
oc apply -f manifests/openshift-storage-subscription.yaml
# Poczekaj na stworzenie StorageCluster CRD
oc wait --for condition=established --timeout=60s crd/storageclusters.ocs.openshift.io
oc apply -f manifests/ocs-storagecluster.yaml



