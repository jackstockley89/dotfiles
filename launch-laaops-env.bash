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

## gets number of appliactions to be used when launching the envs
count=`cat ~/properties/.laaopsproperties | grep ${APP}.${ENV}.* | wc -l | sed 's/ //g'`

 ## statement sets the pem key needed to connect to the correct jump box
if [ ${ENV} == prod ]; then
  key=production
  envlist=`grep "ccms-${APP}*" ~/properties/.production.txt`
elif [ ${ENV} == preprod ]; then
  key=staging
  envlist=`grep "ccms-${APP}*" ~/properties/.staging.txt`
elif [ ${ENV} == test ]; then
  key=test
  envlist=`grep "ccms-${APP}*" ~/properties/.testing.txt`
elif [ ${ENV} == dev ]; then
  key=development
  envlist=`grep "ccms-${APP}*" ~/properties/.development.txt`
else
  echo -e "${CYAN}Unknown Environment: ${RED}${ENV}"
  echo -e "${CYAN}Environment List: ${GREEN}[dev, test, preprod, prod]"
  echo -e "${YELLOW}Use help to show script usage"
  echo -e "launch-env.scpt help${NC}"
  exit 1
fi

## collects the output from above statements and variables and prints to commandline. Depending on user input into this case statement,
## it wiil either launch all addresses for selected app in selected env or printout a list of connection commands.
case "$APP" in

ebs)  echo "Application: ${APP} | Environment: ${ENV}"
      cd
      echo -e "Environment List:"
      echo -e "[Region]        [Address]       [Name]"
      echo -e "${envlist}"
      echo -e "Do you wish to launch all the environments?"
      read -p '[yes/no]: ' yesnovar
      if [ $yesnovar == yes ]; then
            osascript .launch-env-${count}.scpt $(prop '${APP}.${ENV}.*') $key
      elif [ $yesnovar == no ]; then
            echo -e "\nList of connection commands:"
            for i in $(prop '${APP}.${ENV}.*')
            do
            echo -e "ssh $i -i ~.ssh/${key}-general.pem"
            done
      else 
            exit 1
      fi
      ;;
soa)  echo "Application: ${APP} | Environment: ${ENV}"
      cd
      echo -e "Environment List:"
      echo -e "[Region]        [Address]       [Name]"
      echo -e "${envlist}"
      echo -e "Do you wish to launch all the environments?"
      read -p '[yes/no]: ' yesnovar
      if [ $yesnovar == yes ]; then
            osascript .launch-env-${count}.scpt $(prop '${APP}.${ENV}.*') $key
      elif [ $yesnovar == no ]; then
            echo -e "\nList of connection commands:"
            for i in $(prop '${APP}.${ENV}.*')
            do
            echo -e "ssh $i -i ~.ssh/${key}-general.pem"
            done
      else 
            exit 1
      fi
      ;;
edrms) echo "Application: ${APP} | Environment: ${ENV}"
      cd
      echo -e "Environment List:"
      echo -e "[Region]        [Address]       [Name]"
      echo -e "${envlist}"
      echo -e "Do you wish to launch all the environments?"
      read -p '[yes/no]: ' yesnovar
      if [ $yesnovar == yes ]; then
            osascript .launch-env-${count}.scpt $(prop '${APP}.${ENV}.*') $key
      elif [ $yesnovar == no ]; then
            echo -e "\nList of connection commands:"
            for i in $(prop '${APP}.${ENV}.*')
            do
            echo -e "ssh $i -i ~.ssh/${key}-general.pem"
            done
      else 
            exit 1
      fi
      ;;
opa) echo "Application: ${APP} | Environment: ${ENV}"
      cd
      echo -e "Environment List:"
      echo -e "[Region]        [Address]       [Name]"
      echo -e "${envlist}"
      echo -e "Do you wish to launch all the environments?"
      read -p '[yes/no]: ' yesnovar
      if [ $yesnovar == yes ]; then
            osascript .launch-env-${count}.scpt $(prop '${APP}.${ENV}.*') $key
      elif [ $yesnovar == no ]; then
            echo -e "\nList of connection commands:"
            for i in $(prop '${APP}.${ENV}.*')
            do
            echo -e "ssh $i -i ~.ssh/${key}-general.pem"
            done
      else 
            exit 1
      fi
      ;;
pui) echo "Application: ${APP} | Environment: ${ENV}"
      cd
      echo -e "Environment List:"
      echo -e "[Region]        [Address]       [Name]"
      echo -e "${envlist}"
      echo -e "Do you wish to launch all the environments?"
      read -p '[yes/no]: ' yesnovar
      if [ $yesnovar == yes ]; then
            osascript .launch-env-${count}.scpt $(prop '${APP}.${ENV}.*') $key
      elif [ $yesnovar == no ]; then
            echo -e "\nList of connection commands:"
            for i in $(prop '${APP}.${ENV}.*')
            do
            echo -e "ssh $i -i ~.ssh/${key}-general.pem"
            done
      else 
            exit 1
      fi
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