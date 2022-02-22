#!/bin/bash
set -x

APP=$1
ENV=$2
GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

function prop {
    grep "${APP}.${ENV}.*" ~/properties/.laaopsproperties|cut -d'=' -f2
}

count=`cat ~/properties/.laaopsproperties | grep ${APP}.${ENV}.* | wc -l | sed 's/ //g'`
echo ${count}

## open env
case "$APP" in

ebs)  echo "Application: ${APP} | Environment: ${ENV}"
      cd 
      if [ ${ENV} == prod ]; then
        osascript .launch-env-${count}.scpt $(prop 'ebs.prod.*') production
      elif [ ${ENV} == preprod ]; then
        osascript .launch-env-${count}.scpt $(prop 'ebs.preprod.*') staging
      elif [ ${ENV} == test ]; then
        osascript .launch-env-${count}.scpt $(prop 'ebs.test.*') test
      elif [ ${ENV} == dev ]; then
        osascript .launch-env-${count}.scpt $(prop 'ebs.dev.*') development
      else
        echo -e "${CYAN}Unknown Environment: ${RED}${ENV}${NC}"
        echo -e "${CYAN}Environment List: ${GREEN}[dev, test, preprod, prod]${NC}"
        exit
      fi
      ;;
soa)  echo "Application: ${APP} | Environment: ${ENV}"
      cd 
      if [ ${ENV} == prod ]; then
        osascript .launch-env-${count}.scpt $(prop 'soa.prod.*') production
      elif [ ${ENV} == preprod ]; then
        osascript .launch-env-${count}.scpt $(prop 'soa.preprod.*') staging
      elif [ ${ENV} == test ]; then
        osascript .launch-env-${count}.scpt $(prop 'soa.test.*') test
      elif [ ${ENV} == dev ]; then
        osascript .launch-env-${count}.scpt $(prop 'soa.dev.*') development
      else
        echo -e "${CYAN}Unknown Environment: ${RED}${ENV}${NC}"
        echo -e "${CYAN}Environment List: ${GREEN}[dev, test, preprod, prod]${NC}"
        exit
      fi
      ;;
edrms) echo "Application: ${APP} | Environment: ${ENV}"
      cd 
      if [ ${ENV} == prod ]; then
        osascript .launch-env-${count}.scpt $(prop 'edrms.prod.*') production
      elif [ ${ENV} == preprod ]; then
        osascript .launch-env-${count}.scpt $(prop 'edrms.preprod.*') staging
      elif [ ${ENV} == test ]; then
        osascript .launch-env-${count}.scpt $(prop 'edrms.test.*') test
      elif [ ${ENV} == dev ]; then
        osascript .launch-env-${count}.scpt $(prop 'edrms.dev.*') development
      else
        echo -e "${CYAN}Unknown Environment: ${RED}${ENV}${NC}"
        echo -e "${CYAN}Environment List: ${GREEN}[dev, test, preprod, prod]${NC}"
        exit
      fi
      ;;
opa) echo "Application: ${APP} | Environment: ${ENV}"
      cd 
      if [ ${ENV} == prod ]; then
        osascript .launch-env-${count}.scpt $(prop 'opa.prod.*') production
      elif [ ${ENV} == preprod ]; then
        osascript .launch-env-${count}.scpt $(prop 'opa.preprod.*') staging
      elif [ ${ENV} == test ]; then
        osascript .launch-env-${count}.scpt $(prop 'opa.test.*') test
      elif [ ${ENV} == dev ]; then
        osascript .launch-env-${count}.scpt $(prop 'opa.dev.*') development
      else
        echo -e "${CYAN}Unknown Environment: ${RED}${ENV}${NC}"
        echo -e "${CYAN}Environment List: ${GREEN}[dev, test, preprod, prod]${NC}"
        exit
      fi
      ;;
pui) echo "Application: ${APP} | Environment: ${ENV}"
      cd 
      if [ ${ENV} == prod ]; then
        osascript .launch-env-${count}.scpt $(prop 'pui.prod.*') production
      elif [ ${ENV} == preprod ]; then
        osascript .launch-env-${count}.scpt $(prop 'pui.preprod.*') staging
      elif [ ${ENV} == test ]; then
        osascript .launch-env-${count}.scpt $(prop 'pui.test.*') test
      elif [ ${ENV} == dev ]; then
        osascript .launch-env-${count}.scpt $(prop 'pui.dev.*') development
      else
        echo -e "${CYAN}Unknown Environment: ${RED}${ENV}${NC}"
        echo -e "${CYAN}Environment List: ${GREEN}[dev, test, preprod, prod]${NC}"
        exit
      fi
      ;;
help) echo "${APP}"
      echo -e "${CYAN}Application List: ${GREEN}[ebs, soa, edrms, opa, pui]"
      echo -e "${CYAN}Environment List: ${GREEN}[dev, test, preprod, prod]"
      echo -e "${YELLOW}example: launch-env.scpt <Application> <Environement>${NC}"
      ;;
*)    ##if [[ ${ENV} =~ ^(dev|test|preprod|prod)$ ]]; then
      ##  echo -e "${CYAN}Unknown Application: ${RED}${APP}"
      ##  echo -e "${CYAN}Application List: ${GREEN}[ebs, soa, edrms, opa, pui]"
      ##  echo -e "${YELLOW}Use help to show script usage"
      ##  echo -e "launch-env.scpt help${NC}"
      ##else 
      ##  exit 1
      ##fi
      ;;
esac