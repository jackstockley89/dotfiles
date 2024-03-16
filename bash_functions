# .bash_functions

## Example of a function
## function <name>() {
##   <code>
## } 

tfcheck(){
  # Run terraform plan and store the output in a file
  go run ~/.cluster-check.go # checks terraform workspace and cluster context name match
  if [ $? -eq 1 ]; then
    echo "Error: Terraform workspace and cluster context name do not match"
  fi
}