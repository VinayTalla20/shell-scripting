#! /bin/sh

if [ "$1" = "count" ]
then
        echo " REPO $1"
        curl -s -u admin:devops -X 'GET' 'http://192.168.2.113:8081/service/rest/v1/repositories'  -H 'accept: application/json'  -H 'NX-ANTI-CSRF-TOKEN: 0.6435492186789735' | jq .[].name | wc -l


elif [ "$1" = "list" ]
then
       echo "REPO $1"
        curl -s -u admin:devops -X 'GET' 'http://192.168.2.113:8081/service/rest/v1/repositories'  -H 'accept: application/json'  -H 'NX-ANTI-CSRF-TOKEN: 0.6435492186789735'  | jq  .[].name | sed 's/"//g'

elif [ "$1" = "hosted" ]
then
   echo " REPO type $1"
        curl -s -u admin:devops -X 'GET' 'http://192.168.2.113:8081/service/rest/v1/repositories'  -H 'accept: application/json'  -H 'NX-ANTI-CSRF-TOKEN: 0.6435492186789735' | jq ' .[] | select  ( .type == "hosted" ) | .name ' | sed 's/"//g'
fi
