#! /bin/sh

echo "$1"

if  [ "$1" = "images" ]
then
        kubectl get ns
        echo "enter namespace"
        read namespace
        kubectl get pods -n $namespace --show-labels
        echo " enter PodName "
        read podname
        echo -n "IMAGE NAME="; kubectl get pods $podname -n $namespace -o jsonpath={.spec.containers[0].image}
elif [ "$1" = "logs" ]
then
    echo " Getting Logs "
    kubectl get ns
    echo " Enter namespace"
    read namespace
    kubectl get pods -n $namespace
    echo " Enter Pod Name"
    read podname
    echo "logs for pod $podname in namespace $namespace" >> $podname-$namespace-logs.txt
    kubectl logs $podname -n $namespace >> $podname-$namespace-logs.txt
fi
