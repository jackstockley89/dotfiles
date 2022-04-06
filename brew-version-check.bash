#!/bin/bash
#set -x
bold="$(tput bold)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

echo -e "\n${bold}${yellow}Current Package Versions${normal}"
brew list --versions awscli git kubectl vim go tfenv aws-vault cloud-platform-cli helm dagger git-secrets
echo -e "\n${yellow}Would you like to continue to view outdated package versions?${normal}"
read -p '[y/n]: ' yesnovar

if [ $yesnovar == n ]; then
	exit 0
elif [ $yesnovar == y ]; then
	echo -e "\n${bold}${yellow}Outdated Versions${normal}"
	brew outdated
	outdated=`brew outdated | wc -l`
	if [[ $outdated -gt 0 ]]; then
		echo -e "\n${yellow}Would you like to upgrade outdated packages?${normal}"
		read -p '[y/n]: ' yesnovar
		if [ $yesnovar == n ]; then
			exit
		elif [ $yesnovar == y ]; then
			brew upgrade
		else 
			echo -e "\n${bold}${red}Unknown Response $yesnovar${normal}"
			exit 1
		fi
	else
		echo -e "${green}Nothing to upgrade${normal}"
		exit
	fi
else
	echo -e "\n${bold}${red}Unknown Response $yesnovar${normal}"
	exit 1
fi
