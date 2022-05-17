# .bash_functions

## Example of a function
## function <name>() {
##   <code>
## } 

## Set AWS Profile 
profiles="moj-cp jacksapp-dev"
function setawsp() {
  if [ "${1}" == `echo $profiles | awk '{print $1}'` ]; then
    echo -e "\nSetting AWS Profile to ${1}"
  elif [ "${1}" == `echo $profiles | awk '{print $2}'` ]; then
    echo -e "\nSetting AWS Profile to ${1}"
  else
    echo -e "\nInvalid Profile"
    echo -e "Valid Profiles: ${profiles}"
    echo -e "Exiting..."
    echo -e "\n"
    return
  fi
  export AWS_PROFILE=$1
  export AWS_CONFIG_FILE=~/.aws/cloud-platform/config
  export AWS_SHARED_CREDENTIALS_FILE=~/.aws/cloud-platform/credentials
  export AWS_REGION=eu-west-2
  export AWS_DEFAULT_REGION=$AWS_REGION
  echo -e "AWS_PROFILE: ${AWS_PROFILE}"
  echo -e "AWS_CONFIG_FILE: ${AWS_CONFIG_FILE}"; 
  echo -e "AWS_SHARED_CREDENTIALS_FILE: ${AWS_SHARED_CREDENTIALS_FILE}"
  echo -e "AWS_REGION: ${AWS_REGION}"
  echo -e "AWS_DEFAULT_REGION: ${AWS_DEFAULT_REGION}"
  echo -e "\n"
}

## Set K8s Config
function setkcfg() {
  if [ "${1}" == "live" ]; then
    export KUBECONFIG=~/.kube/live/config
  elif [ "${1}" == "test" ]; then
    export KUBECONFIG=~/.kube/test/config
  elif [ "${1}" == "jacksapp" ]; then
    export KUBECONFIG=~/.kube/jacksapp/config
  elif [ "${1}" == "minikube" ]; then
    export KUBECONFIG=~/.kube/minikube/config
  else
    echo -e "\nInvalid K8s Config"
    echo -e "Valid Configs: live, test, jacksapp, minikube"
    echo -e "Exiting..."
    echo -e "\n"
    return
  fi
  echo -e "\nKUBECONFIG: ${KUBECONFIG}"
  echo -e "\n"
  return
}

function setmakefile() {
  if [ -f ~/.env_address ]; then
    source  ~/.env_address
  else
    print "404: ~/.zsh/env_address not found."
  fi

  if [ "${1}" == "hoowdaw" ]; then
    export KUBECONFIG_S3_BUCKET="cloud-platform-concourse-kubeconfig"
    export KUBECONFIG_S3_KEY="kubeconfig"
    export KUBE_CONFIG_PATH="/tmp/kubeconfig"
    export HOODAW_API_KEY="soopersekrit"
    export HOODAW_HOST="http://localhost:4567"
    export AWS_REGION="eu-west-2"
    export AWS_PROFILE="moj-cp"
  else 
    echo -e "\nInvalid makefile enviroment parameter"
    echo -e "Valid makefile enviroments parameter: hoowdaw"
    echo -e "Exiting..."
    echo -e "\n"
    return
  fi
}