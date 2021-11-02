#!/bin/bash

ENV=$2
scriptHome=~
. ~/properties/.laaopsproperties

## open env
case "$1" in

ebs)  echo "${1}: ${ENV}"
      cd ${scriptHome}
      if [ ${ENV} == prod ]; then
        osascript .launch-env.scpt $ebsPRODDB $ebsPRODAPPONE $ebsPRODAPPTWO production
      elif [ ${ENV} == pre-prod ]; then
        osascript .launch-env.scpt $ebsPREPRODDB $ebsPREPRODAPPONE $ebsPREPRODAPPTWO staging
      elif [ ${ENV} == test ]; then
        osascript .launch-env.scpt $ebsPREPRODDB $ebsPREPRODAPPONE testing
      elif [ ${ENV} == dev ]; then
        osascript .launch-env.scpt $ebsPREPRODDB $ebsPREPRODAPPONE development
      else
        echo "Unknown Environment"
        exit
      fi
      ;;
soa)  echo "${1}: ${ENV}"
      cd "${scriptHome}"
      if [ ${ENV} == prod ]; then
        osascript .launch-env.scpt $soaPRODADMIN $soaPRODAPPONE $soaPRODAPPTWO $soaPRODAPPTHREE production
      elif [ ${ENV} == pre-prod ]; then
        osascript .launch-env.scpt $soaPREPRODADMIN $soaPREPRODAPPONE $soaPREPRODAPPTWO $soaPREPRODAPPTHREE staging
      elif [ ${ENV} == test ]; then
        osascript .launch-env.scpt $soaPREPRODADMIN $soaPREPRODAPPONE testing
      elif [ ${ENV} == dev ]; then
        osascript .launch-env.scpt $soaPREPRODADMIN $soaPREPRODAPPONE development
      else
        echo "Unknown Environment"
        exit
      fi
      ;;
edrms) echo "${1}: ${ENV}"
       cd "${scriptHome}"
      if [ ${ENV} == prod ]; then
        osascript .launch-env.scpt $edrmsPRODAPPONE $edrmsPRODAPPTWO production
      elif [ ${ENV} == pre-prod ]; then
        osascript .launch-env.scpt $edrmsPREPRODAPPONE $edrmsPREPRODAPPTWO staging
      elif [ ${ENV} == test ]; then
        osascript .launch-env.scpt $edrmsPREPRODAPPONE $edrmsPREPRODAPPTWO testing
      elif [ ${ENV} == dev ]; then
        osascript .launch-env.scpt $edrmsPREPRODAPPONE $edrmsPREPRODAPPTWO development
      else
        echo "Unknown Environment"
        exit
      fi
      ;;
*)    echo "Unknown Enviroment ${ENV}"
      ;;
esac