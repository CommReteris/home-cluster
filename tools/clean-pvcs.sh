#!/bin/bash
for NAMESPACE in $(kubectl get namespaces --all-namespaces | awk '{print $1}');
    for PVC in $(kubectl get persistentvolumeclaims -n NAMESPACE | awk '/-/ {print $1}'); do
        echo PVC
        kubectl get persistentvolumeclaim/"$PVC" -o name -n NAMESPACE | \
        xargs -I {} kubectl patch {} -n NAMESPACE --type merge -p '{"metadata":{"finalizers": []}}'
    done
done
