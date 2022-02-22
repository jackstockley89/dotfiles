#!/bin/bash

ENV=$2

function prop {
    grep "${1}" ~/properties/.laaopsproperties|cut -d'=' -f2
}

## open env
case "$1" in

ebs)  echo "${1}: ${ENV}"
      cd ${scriptHome}
      count=`cat ~/properties/.laaopsproperties | grep ${1}.${ENV}.* | wc -l | sed 's/ //g'`
      if [ ${ENV} == prod ]; then
        osascript .launch-env-${count}.scpt $(prop 'ebs.prod.*') production
      elif [ ${ENV} == preprod ]; then
        osascript .launch-env-${count}.scpt $(prop 'ebs.preprod.*') staging
      elif [ ${ENV} == test ]; then
        osascript .launch-env-${count}.scpt $(prop 'ebs.test.*') test
      elif [ ${ENV} == dev ]; then
        osascript .launch-env-${count}.scpt $(prop 'ebs.dev.*') development
      else
        echo "Unknown Environment"    
        exit
      fi
      ;;
soa)  echo "${1}: ${ENV}"
      cd ${scriptHome}
      count=`cat ~/properties/.laaopsproperties | grep ${1}.${ENV}.* | wc -l | sed 's/ //g'`
      if [ ${ENV} == prod ]; then
        osascript .launch-env-${count}.scpt $(prop 'soa.prod.*') production
      elif [ ${ENV} == preprod ]; then
        osascript .launch-env-${count}.scpt $(prop 'soa.preprod.*') staging
      elif [ ${ENV} == test ]; then
        osascript .launch-env-${count}.scpt $(prop 'soa.test.*') test
      elif [ ${ENV} == dev ]; then
        osascript .launch-env-${count}.scpt $(prop 'soa.dev.*') development
      else
        echo "Unknown Environment"    
        exit
      fi
      ;;
edrms) echo "${1}: ${ENV}"
      cd ${scriptHome}
      count=`cat ~/properties/.laaopsproperties | grep ${1}.${ENV}.* | wc -l | sed 's/ //g'`
      if [ ${ENV} == prod ]; then
        osascript .launch-env-${count}.scpt $(prop 'edrms.prod.*') production
      elif [ ${ENV} == preprod ]; then
        osascript .launch-env-${count}.scpt $(prop 'edrms.preprod.*') staging
      elif [ ${ENV} == test ]; then
        osascript .launch-env-${count}.scpt $(prop 'edrms.test.*') test
      elif [ ${ENV} == dev ]; then
        osascript .launch-env-${count}.scpt $(prop 'edrms.dev.*') development
      else
        echo "Unknown Environment"    
        exit
      fi
      ;;
opa) echo "${1}: ${ENV}"
      cd ${scriptHome}
      count=`cat ~/properties/.laaopsproperties | grep ${1}.${ENV}.* | wc -l | sed 's/ //g'`
      if [ ${ENV} == prod ]; then
        osascript .launch-env-${count}.scpt $(prop 'opa.prod.*') production
      elif [ ${ENV} == preprod ]; then
        osascript .launch-env-${count}.scpt $(prop 'opa.preprod.*') staging
      elif [ ${ENV} == test ]; then
        osascript .launch-env-${count}.scpt $(prop 'opa.test.*') test
      elif [ ${ENV} == dev ]; then
        osascript .launch-env-${count}.scpt $(prop 'opa.dev.*') development
      else
        echo "Unknown Environment"    
        exit
      fi
      ;;
pui) echo "${1}: ${ENV}"
      cd ${scriptHome}
      count=`cat ~/properties/.laaopsproperties | grep ${1}.${ENV}.* | wc -l | sed 's/ //g'`
      if [ ${ENV} == prod ]; then
        osascript .launch-env-${count}.scpt $(prop 'pui.prod.*') production
      elif [ ${ENV} == preprod ]; then
        osascript .launch-env-${count}.scpt $(prop 'pui.preprod.*') staging
      elif [ ${ENV} == test ]; then
        osascript .launch-env-${count}.scpt $(prop 'pui.test.*') test
      elif [ ${ENV} == dev ]; then
        osascript .launch-env-${count}.scpt $(prop 'pui.dev.*') development
      else
        echo "Unknown Environment"    
        exit
      fi
      ;;
help) echo "${1} ${ENV}"
      echo "Application List: ebs, soa, edrms, opa, pui"
      echo "Environment List: dev, test, preprod, prod"
      echo "example: launch-env.scpt <Application> <Environement>"
      ;;
*)    echo "Unknown Application ${1} or Enviroment ${ENV}"
      echo "Use help to show script usage"
      echo "launch-env.scpt help"
      ;;
esac