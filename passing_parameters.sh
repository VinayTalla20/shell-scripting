#!/bin/bash

# Check if yq is installed
if ! command -v yq &> /dev/null
then
    # If yq is not installed, install it
    echo "yq not found. Installing..."
    sudo snap install yq
else
    echo "yq already installed. Skipping installation."
fi

while getopts ":s:k:" opt; do
  case ${opt} in
    s )
      # process name option
      tagname=${OPTARG}
      ;;
    k )
      # process keyvaulttagname option
      keyvaulttagname=${OPTARG}
      ;;
    \? )
      # invalid option
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    : )
      # missing argument
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))


echo "Tag for Secpack"

echo "Tag name is: $tagname"

yq -i eval '.azsecpack.azsecpackContainer.image = "'$tagname'"' values.yaml

echo "Tag for Key Vault"

echo "Tag name is: $keyvaulttagname"

yq -i eval '.azsecpack.initSecretsContainer.image = "'$keyvaulttagname'"' values.yaml


#AZPACK=$(helm list -A | grep -i helm-16 | awk '//{print $1 }')

#NAMESPACE=$(helm list -A | grep -i helm-16 | awk '//{print $2 }')

#helm unistall $AZPACK -n $NAMESPACE

#helm install $AZPACK -n $NAMESPACE .
