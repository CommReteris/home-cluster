#!/bin/bash
for CRD in $(kubectl get crd -n rook-ceph | awk '/ceph.rook.io/ {print $1}'); do
    if [ $CRD != 'cephclusters.ceph.rook.io' ]; then
        kubectl get -n rook-ceph "$CRD" -o name | \
        xargs -I {} kubectl patch -n rook-ceph {} --type merge -p '{"metadata":{"finalizers": []}}'
    else
        kubectl get -n rook-ceph "$CRD" -o name | \
        xargs -I {} kubectl patch -n rook-ceph {}  --type merge \
         -p '{"spec":{"cleanupPolicy":{"confirmation":"yes-really-destroy-data"}}}'
    fi
    kubectl get -n rook-ceph "$CRD" -o name | xargs -I {} kubectl delete -n rook-ceph {}
done
