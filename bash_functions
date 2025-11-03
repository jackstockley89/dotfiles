# .bash_functions

## Example of a function
## function <name>() {
##   <code>
## } 

dir="/Users/jack.stockley/repo/jackstockley89/dotfiles/wrapper_scripts/go"

tfcheck(){
  # Run terraform plan and store the output in a file
  go run $dir/.cluster-check.go # checks terraform workspace and cluster context name match
  if [ $? -eq 1 ]; then
    echo "Error: Terraform workspace and cluster context name do not match"
  fi
}

tfplan(){
  # Run terraform plan and store the output in a file
  go run $dir/cluster-check.go # checks terraform workspace and cluster context name match
  if [ $? -eq 1 ]; then
    echo "Error: Terraform workspace and cluster context name do not match"
  fi
  terraform plan -out=/tmp/plan.out > /dev/null 2>&1
}

tfapply(){
  # Run terraform apply using the plan file
  go run $dir/cluster-check.go # checks terraform workspace and cluster context name match
  if [ $? -eq 1 ]; then
    echo "Error: Terraform workspace and cluster context name do not match"
  fi
  terraform apply /tmp/plan.out
}