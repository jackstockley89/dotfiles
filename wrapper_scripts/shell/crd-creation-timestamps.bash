#!/bin/bash

source ~/.wrapper_scripts/functions/colours_func.bash

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

crd




