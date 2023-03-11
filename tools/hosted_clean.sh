#!/bin/bash
for PVC in $(kubectl get persistentvolumeclaims -n rook-ceph | awk '/-lvm/ {print $1}'); do
    echo PVC
    kubectl get persistentvolumeclaim/"$PVC" -o name -n rook-ceph | \
    xargs -I {} kubectl patch {} -n rook-ceph --type merge -p '{"metadata":{"finalizers": []}}'
done
