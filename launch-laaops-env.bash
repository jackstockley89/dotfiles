#!/bin/bash

ENV=$2
scriptHome=~
. ~/properties/.laaopsproperties

## open env
case "$1" in

ebs)  echo "${1}: ${ENV}"
      cd ${scriptHome}
      if [ ${ENV} == prod ]; then
        osascript .launch-env.scpt $ebsPRODDB $ebsPRODAPPONE $ebsPRODAPPTWO
      elif [ ${ENV} == pre-prod ]; then
        osascript .launch-env.scpt $ebsPREPRODDB $ebsPREPRODAPPONE $ebsPREPRODAPPTWO
      else
        echo "Unknown Environment"
        exit
      fi
      ;;
soa)  echo "${1}: ${ENV}"
      cd "${scriptHome}"
      if [ ${ENV} == prod ]; then
        osascript .launch-env.scpt $soaPRODADMIN $soaPRODAPPONE $soaPRODAPPTWO $soaPRODAPPTHREE
      elif [ ${ENV} == pre-prod ]; then
        osascript .launch-env.scpt $soaPREPRODADMIN $soaPREPRODAPPONE $soaPREPRODAPPTWO $soaPREPRODAPPTHREE
      else
        echo "Unknown Environment"
        exit
      fi
      ;;
edrms) echo "${1}: ${ENV}"
       cd "${scriptHome}"
      if [ ${ENV} == prod ]; then
        osascript .launch-env.scpt $edrmsPRODAPPONE $edrmsPRODAPPTWO
      elif [ ${ENV} == pre-prod ]; then
        osascript .launch-env.scpt $edrmsPREPRODAPPONE $edrmsPREPRODAPPTWO
      else
        echo "Unknown Environment"
        exit
      fi
      ;;
*)    echo "Unknown Enviroment ${ENV}"
      ;;
esac