#! /bin/sh

echo "$1"

if  [ "$1" = "images" ]
then
        echo "enter verb type"
        read verb
        echo "enter object type"
        read object
        kubectl get ns
        echo "enter namespace"
        read namespace
        kubectl $verb $object -n $namespace --show-labels
        echo "enter labels to find: format key=value"
        read labels
        kubectl $verb  $object -n $namespace --show-labels | grep -i $labels > pod.text
        PODNAME=$(awk '{print $1}' pod.text | head -1 )
        echo "IMAGE NAME"; kubectl $verb $object $PODNAME -n $namespace -o json | jq .spec.containers | jq .[].image | sed 's/"//g'
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
