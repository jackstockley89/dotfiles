# .bash_functions

## Set AWS Profile 
function setprofile() {
  export AWS_PROFILE=$1
  echo "AWS_PROFILE: ${AWS_PROFILE}"
}