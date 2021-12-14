#!/bin/bash

ENV=$2

function prop {
    grep "${1}" ~/properties/.laaopsproperties|cut -d'=' -f2
}

## open env
case "$1" in

ebs)  echo "${1}: ${ENV}"
      cd ${scriptHome}
      if [ ${ENV} == prod ]; then
        osascript .launch-env-3.scpt $(prop 'ebs.prod.*') production
      elif [ ${ENV} == pre-prod ]; then
        osascript .launch-env-3.scpt $(prop 'ebs.preprod.*') staging
      elif [ ${ENV} == test ]; then
        osascript .launch-env-2.scpt $(prop 'ebs.test.*') test
      elif [ ${ENV} == dev ]; then
        osascript .launch-env-2.scpt $(prop 'ebs.dev.*') development
      else
        echo "Unknown Environment"    
        exit
      fi
      ;;
soa)  echo "${1}: ${ENV}"
      cd ${scriptHome}
      if [ ${ENV} == prod ]; then
        osascript .launch-env-4.scpt $(prop 'soa.prod.*') production
      elif [ ${ENV} == pre-prod ]; then
        osascript .launch-env-4.scpt $(prop 'soa.preprod.*') staging
      elif [ ${ENV} == test ]; then
        osascript .launch-env-2.scpt $(prop 'soa.test.*') test
      elif [ ${ENV} == dev ]; then
        osascript .launch-env-2.scpt $(prop 'soa.dev.*') development
      else
        echo "Unknown Environment"    
        exit
      fi
      ;;
edrms) echo "${1}: ${ENV}"
      cd ${scriptHome}
      if [ ${ENV} == prod ]; then
        osascript .launch-env-2.scpt $(prop 'edrms.prod.*') production
      elif [ ${ENV} == pre-prod ]; then
        osascript .launch-env-2.scpt $(prop 'edrms.preprod.*') staging
      elif [ ${ENV} == test ]; then
        osascript .launch-env-2.scpt $(prop 'edrms.test.*') test
      elif [ ${ENV} == dev ]; then
        osascript .launch-env-2.scpt $(prop 'edrms.dev.*') development
      else
        echo "Unknown Environment"    
        exit
      fi
      ;;
help) echo "${1}"
      echo "Application List: ebs, soa, edrms"
      echo "Environment List: dev, test, pre-prod, prod"
      echo "example: launch-env.scpt <Application> <Environement>"
      ;;
*)    echo "Unknown Enviroment ${ENV}"
      echo "Use help to show script usage"
      echo "launch-env.scpt help"
      ;;
esac