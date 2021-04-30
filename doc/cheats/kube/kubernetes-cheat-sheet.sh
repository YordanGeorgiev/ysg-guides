

while read -r ns; do 
  while read -r p ; do  
  echo kubectl logs --namespace $ns $p \| grep -i -A 20 -B 2 --color=always '"$str"' \| head -n 1000 \|wc -l
  # echo kubectl logs --namespace $ns $p \| grep -i -A 20 -B 2 --color=always '"$str"' \| head -n 1000 \| less -R
  done < <(kubectl --namespace $ns get pods |awk '{print $1}') ;
done < <(cat <<EOF
service
ns2
EOF
)


# run a deployment file chck change-scripts-runs
kubectl create -f 1_dry_run.yml

# get the the pods 
kubectl --namespace=serviceportal get pods -l sp-change-script-job-94894



# how-to get the name of the pod(s) by the job name
kubectl --namespace=serviceportal get pods -l sp-change-script-job-94894


while read -r p ; do echo kubectl logs $p ; done < <(kubectl get pods | grep spid06|awk '{print $1}')


kubectl logs sp-change-script-job-94894-mg8f8


while read -r pp; do 
	echo pp:$pp
done < <(cat <<EOF
private
public
EOF
)


# generate a search for errors call per pod for a (list) of namespaces 
str='first.last@company.se'
echo 'echo srch for the following str: "'$str'"';
while read -r ns; do 
	while read -r p ; do  
	echo kubectl logs --namespace $ns $p \| grep -i -A 20 -B 2 --color=always '"$str"' \| head -n 1000 \|wc -l
	# echo kubectl logs --namespace $ns $p \| grep -i -A 20 -B 2 --color=always '"$str"' \| head -n 1000 \| less -R
	done < <(kubectl --namespace $ns get pods | grep Running |awk '{print $1}') ;
done < <(cat <<EOF
ns1
ns2
EOF
)



kubectl logs $pod  
kubectl exec --stdin --tty $pod_to_attach_to -- /bin/bas

ns='serviceportal'; kubectl config set-context --current --namespace serviceportal

kubectl config set-context $(kubectl config current-context) --namespace=serviceportal
kubectl config view | grep namespace
kubectl get pods | grep spid06

while read -r ns; do kubectl config use-context $ns-admin@kubernetes; kubectl get pods ; done < <(cat <<EOF
ns1
ns2
EOF
)



# Show Merged kubeconfig settings.
kubectl config view 

# to reconfigure if errors
sudo rm -r ~/.minikube ; minikube stop; minikube delete ; minikube start

# use multiple kubeconfig files at the same time and view merged config
export KUBECONFIG=~/.kube/config:~/.kube/kubconfig2 


# how-to delete deployments
kubectl delete pods $pod_name

# run commands against cluster config file 
kubectl --kubeconfig ~/.ssh/stg.yml get pods


kubectl config view


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




# 
kubectl create deployment nginx --image=nginx:1.10.0


kubectl create -f pods/monolith.yaml

kubectl describe pods pod-name


kubectl get pods secure-monolith --show-labels

kubectl get events --sort-by='.lastTimestamp'

# how-to update containwers image 
kubectl patch pod valid-pod -p '{"spec":{"containers":[{"name":"kubernetes-serve-hostname","image":"new image"}]}}'

echo << EOF_DOCKER_REGISTRY_CONF_01 >> ~/.docker/config.json
{
   "auths": {
      "REGISTRY": {
         "auth": "base64(USERNAME:PASSWORD)"
      }
   },
   "HttpHeaders": {
      "User-Agent": "Docker-Client/18.09.7 (linux)"
   }
}
EOF_DOCKER_REGISTRY_CONF_01


echo << EOF_DOCKER_REGISTRY_CONF_02 >> ~/.docker/config.json
{
  "stackOrchestrator" : "swarm",
  "credsStore" : "desktop",
  "HttpHeaders" : {
    "User-Agent" : "Docker-Client/19.03.5 (darwin)"
  },
  "auths" : {
    "registry.vaultit.org": { "auth": "xx foobar xx" }
  }
}
EOF_DOCKER_REGISTRY_CONF_02



cat kubernetes/${deploy_to_environment}/${deployment_file} |  
  sed -e "s#IMAGE#${docker_image_name}:${docker_tag}#g" | \
  ssh -o StrictHostKeyChecking=no centos@${admin_host} kubectl --namespace=${namespace} apply -f -'

kubectl rollout status --namespace=${namespace} deployments ${deployment_name}
