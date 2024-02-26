#!/bin/bash

source ~/.wrapper_scripts/functions/colours_func.bash

cert(){
  # Search for certificate creation timestamp in cluster 
  # and print the certificate name and creation timestamp

  # Get the list of certificates in the cluster storing the names and namespaces in separate arrays
  certs=($(kubectl get certificates --all-namespaces -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}'))
  namespaces=($(kubectl get certificates --all-namespaces -o jsonpath='{range .items[*]}{.metadata.namespace}{"\n"}{end}'))

  # Loop through the list of certificates
  echo -e "$(ColorGreen "Certificates:")"
  echo -e "------------\n"
  for ((i=0;i<${#certs[@]};++i)); do
    # Get the certificate creation timestamp
    timestamp=$(kubectl get certificates -n ${namespaces[$i]} ${certs[$i]} -o jsonpath='{.metadata.creationTimestamp}')
    # Print the certificate name and creation timestamp
    echo "Namespace: ${namespaces[$i]}, Certificate Name: ${certs[$i]} created at ${timestamp}"
  done
}

crd(){
  # Search for all CustomResourceDefinition objects in the cluster
  # and print the CRD name and creation timestamp

  # Get the list of CRDs in the cluster storing the names in an array
  crds=($(kubectl get crds -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}'))

  # Loop through the list of CRDs
  echo -e "\n$(ColorGreen "CustomResourceDefinitions:")"
  echo -e "-------------------------\n"
  for ((i=0;i<${#crds[@]};++i)); do
    # Get the CRD creation timestamp
    timestamp=$(kubectl get crds -A ${crds[$i]} -o jsonpath='{.metadata.creationTimestamp}')
    # Print the CRD name and creation timestamp
    echo "CRD Name: ${crds[$i]} created at ${timestamp}"
  done
}

read -p "Enter the object type (cert/crd): " object_type
case $object_type in
  cert)
    cert
    ;;
  crd)
    crd
    ;;
  *)
    echo "Invalid object type"
    ;;
esac




