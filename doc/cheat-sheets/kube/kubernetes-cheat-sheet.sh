
# how-to delete deployments
kubectl delete pods $pod_name

# run commands against cluster config file 
kubectl --kubeconfig ~/.ssh/stg.yml get pods


# how-to get deployments 
kubectl get deployments

# how-to check kubernetes version 
kubectl version

# attach to a running docker from a specific namespaec 
kubectl --namespace secret-stories exec -it story-db-stg-postgresql-0 bash

# src: https://kubernetes.io/docs/reference/kubectl/cheatsheet/#kubectl-autocomplete
kubectl get pods --all-namespaces             # List all pods in all namespaces

# get the pods from one namespace 
kubectl get pods --namespace=secret-stories

kubectl get nodes


hostpath ti

poland outsouring 

