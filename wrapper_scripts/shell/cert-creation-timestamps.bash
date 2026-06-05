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
cert




