#!/bin/bash

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
list=`grep -w ${APP}.${ENV}.* ~/properties/.laaopsproperties`

if [ ${ENV} == prod ]; then
  key=production
elif [ ${ENV} == preprod ]; then
  key=staging
elif [ ${ENV} == test ]; then
  key=test
elif [ ${ENV} == dev ]; then
  key=development
else
  echo -e "${CYAN}Unknown Environment: ${RED}${ENV}"
  echo -e "${CYAN}Environment List: ${GREEN}[dev, test, preprod, prod]"
  echo -e "${YELLOW}Use help to show script usage"
  echo -e "launch-env.scpt help${NC}"
  exit 1
fi

## open env
case "$APP" in

ebs)  echo "Application: ${APP} | Environment: ${ENV}"
      cd
      echo -e "\n${list}"
      osascript .launch-env-${count}.scpt $(prop '${APP}.${ENV}.*') $key
      ;;
soa)  echo "Application: ${APP} | Environment: ${ENV}"
      cd
      echo -e "\n${list}"
      osascript .launch-env-${count}.scpt $(prop '${APP}.${ENV}.*') $key
      ;;
edrms) echo "Application: ${APP} | Environment: ${ENV}"
      cd
      echo -e "\n${list}"
      osascript .launch-env-${count}.scpt $(prop '${APP}.${ENV}.*') $key
      ;;
opa) echo "Application: ${APP} | Environment: ${ENV}"
      cd
      echo -e "\n${list}"
      osascript .launch-env-${count}.scpt $(prop '${APP}.${ENV}.*') $key
      ;;
pui) echo "Application: ${APP} | Environment: ${ENV}"
      cd
      echo -e "\n${list}"
      osascript .launch-env-${count}.scpt $(prop '${APP}.${ENV}.*') $key
      ;;
help) echo "${APP}"
      echo -e "${CYAN}Application List: ${GREEN}[ebs, soa, edrms, opa, pui]"
      echo -e "${CYAN}Environment List: ${GREEN}[dev, test, preprod, prod]"
      echo -e "${YELLOW}example: launch-env.scpt <Application> <Environement>${NC}"
      ;;
*)    echo -e "${CYAN}Unknown Application: ${RED}${APP}"
      echo -e "${CYAN}Application List: ${GREEN}[ebs, soa, edrms, opa, pui]"
      echo -e "${YELLOW}Use help to show script usage"
      echo -e "launch-env.scpt help${NC}"
      exit 1
      ;;
esac