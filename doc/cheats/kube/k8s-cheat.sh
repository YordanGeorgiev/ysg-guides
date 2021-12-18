# file: kubernetes - cheat -sheet
# 
# src: 
# https://kubernetes.io/docs/reference/kubectl/cheatsheet/

clear; while read -r d; do echo kubectl -n default rollout restart deployment/$d ; done < <(kubectl -n default get deployments|awk '{print $1}'|tail -n +2)
clear; while read -r d; do echo kubectl -n default scale deployment $d --replicas=2; done < <(kubectl -n default get deployments|awk '{print $1}'|tail -n +2)


for namespace in `echo namespace-01 namespace-02`; do
  while read -r pod ; do
    while read -r container ; do
      echo START ::: POD: $pod , CONTAINER : $container 
      echo kubectl -n $namespace exec -it $pod -c $container -- env
      echo STOP ::: POD: $pod , CONTAINER : $container 
    done < <(kubectl -n $namespace get pods -o json | jq -r ".items[]|select(.metadata.name | contains ( \"$pod\"))| .status.containerStatuses[].name") ;
  done < <(kubectl -n $namespace get pods -o json | jq -r '.items[].metadata.name')
done
    

# get all secrets used by a pod
kubectl -n apiv2 get pods -o json | jq -r '.items[].spec.containers[].env[]?.valueFrom.secretKeyRef.name' | grep -v null | sort | uniq


while read -r pod ; do while read -r container ; do echo kubectl -n apiv2 logs $pod $container; done < <(kubectl -n apiv2 get pods -o json | jq -r ".items[]|select(.metadata.name | contains ( \"$pod\"))| .status.containerStatuses[].name") ; done < <(kubectl -n apiv2 get pods -o json | jq -r '.items[].metadata.name')

kubectl -n kube-system edit configmap/aws-auth
kubectl -n kube-system edit configmap coredns 
kubectl -n kube-system get configmap coredns -o jsonpath='{$.data.Corefile}'


# in src/java/person/src/test/resources/application.yml

  datasource:
    url: "jdbc:tc:postgresql:11.1:///localhost:5234/person_db"
    username: ${DB_USERNAME}
    password: ${DB_PASSWORD}
    driver-class-name: org.testcontainers.jdbc.ContainerDatabaseDriver

    

### how-to check a deployment status 
kubectl -n $ns rollout status deployments $deployment_name





# how-to filter by attribute name from array of items 
kubectl get services --all-namespaces -o json | jq -r \
  '.items[] | select( .metadata.name | contains("api-doc")) | { name: .metadata.name, ns: .metadata.namespace , nodePort: .spec.ports[].nodePort, port: .spec.ports[].port}'

# start a pod where you can make curl commands from
kubectl run $my_pod_name --image=radial/busyboxplus:curl -n $my_namespace -i --tty --rm

# how-to port forward with k8s
kubectl port-forward --namespace test-service svc/redis-master 6379:6379

# start a port forward to easier consume browser stuff
kubectl port-forward -n $ns service/$service_name $my_local_port:$my_remote_port

kubectl -n kubernetes-dashboard describe service kubernetes-dashboard
kubectl describe configmap -n kube-system aws-auth
kubectl describe service -n default spectralha-api-central
kubectl get deployments --all-namespaces
kubectl get deploy kubernetes-dashboard -n kubernetes-dashboard -o yaml

kubectl rollout restart deployment/deployment-name
# get the end points
kubectl describe service  -n kubernetes-dashboard kubernetes-dashboard

# how-to restart all the deployments from a namespace
while read -r d ; do echo kubectl -n apiv2 rollout restart deployment/$d ; done < <(kubectl get deployments -n apiv2|grep -v NAME|awk '{print $1}')

kubectl describe configmap -n kube-system aws-auth

kubectl rollout restart deployment/deployment-name

# how-to restart pods 
kubectl get pods -n ns
kubectl scale deployment deployment-name --replicas=2 -n ns
kubectl scale deployment deployment-name --replicas=0 -n ns
kubectl describe pods -n ns
kubectl describe nodes 


while read -r pod ; do kubectl describe pods -n default $pod; done < <(kubectl get pods --all-namespaces|grep -i prometheus| awk '{print $2}')

get the log errors

while read -r pod ; do kubectl logs  -n default $pod --tail 1000 ; done < <(kubectl get pods --all-namespaces|grep -i entitlement| awk '{print $2}')


alias memalloc='util | grep % | awk '\''{print $3}'\'' | awk '\''{ sum += $1 } END { if (NR > 0) { result=(sum*100)/(NR*1600); printf result/NR "%\n" } }'\'''
# Get CPU request total (we x20 because because each m3.large has 2 vcpus (2000m) )
alias cpualloc='util | grep % | awk '\''{print $1}'\'' | awk '\''{ sum += $1 } END { if (NR > 0) { print sum/(NR*20), "%\n" } }'\'''

# Get mem request total (we x75 because because each m3.large has 7.5G ram )
alias memalloc='util | grep % | awk '\''{print $5}'\'' | awk '\''{ sum += $1 } END { if (NR > 0) { print sum/(NR*75), "%\n" } }'\'''
kubectl top pod
kubectl get po --all-namespaces -o=jsonpath="{range .items[*]}{.metadata.namespace}:{.metadata.name}{'\n'}{range .spec.containers[*]}  {.name}:{.resources.requests.cpu}{'\n'}{end}{'\n'}{end}"


while read -r ns; do 
  while read -r p ; do  
  echo kubectl logs -n $ns $p \| grep -i -A 20 -B 2 --color=always '"$str"' \| head -n 1000 \|wc -l
  # echo kubectl logs -n $ns $p \| grep -i -A 20 -B 2 --color=always '"$str"' \| head -n 1000 \| less -R
  done < <(kubectl -n $ns get pods |awk '{print $1}') ;
done < <(cat <<EOF
service
ns2
EOF
)

      --web.external-url=http://prometheus-operator-alertmanager.monitoring:9093
      --web.external-url=http://prometheus-operator-prometheus.monitoring:9090

# run a deployment file chck change-scripts-runs
kubectl create -f 1_dry_run.yml

# get the the pods 
kubectl -n=serviceportal get pods -l sp-change-script-job-94894



# how-to get the name of the pod(s) by the job name
kubectl -n=serviceportal get pods -l sp-change-script-job-94894


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
str='Sven'
echo 'echo srch for the following str: "'$str'"';
while read -r ns; do 
	while read -r p ; do  
	echo kubectl logs -n $ns $p \| grep -i -A 20 -B 2 --color=always '"$str"' \| head -n 1000 \|wc -l
	# echo kubectl logs -n $ns $p \| grep -i -A 20 -B 2 --color=always '"$str"' \| head -n 1000 \| less -R
	done < <(kubectl -n $ns get pods | grep Running |awk '{print $1}') ;
done < <(cat <<EOF
ns1
ns2
EOF
)



kubectl logs $pod  
kubectl exec --stdin --tty $pod_to_attach_to -- /bin/bash

ns='serviceportal'; kubectl config set-context --current -n serviceportal

kubectl config set-context $(kubectl config current-context) -n=serviceportal
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
kubectl -n secret-stories exec -it story-db-stg-postgresql-0 bash

# src: https://kubernetes.io/docs/reference/kubectl/cheatsheet/#kubectl-autocomplete
kubectl get pods --all-namespaces             # List all pods in all namespaces

# get the pods from one namespace 
kubectl get pods -n=secret-stories

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
  ssh -o StrictHostKeyChecking=no centos@${admin_host} kubectl -n=${namespace} apply -f -'

kubectl rollout status -n=${namespace} deployments ${deployment_name}
