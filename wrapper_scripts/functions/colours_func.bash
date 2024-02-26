#!/bin/bash

green='\e[32m'
blue='\e[34m'
red='\e[31m'
clear='\e[0m'

ColorGreen(){
	echo -ne $green$1$clear
}

ColorBlue(){
	echo -ne $blue$1$clear
}

ColorRed(){
  echo -ne $red$1$clear
}