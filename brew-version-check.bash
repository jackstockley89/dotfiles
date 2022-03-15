#!/bin/bash

echo -e "Current Package Versions"
brew list --versions awscli git kubectl vim go tfenv aws-vault
echo -e "Would you like to continue to view outdated package versions?"
read -p '[y/n]: ' yesnovar

if [ $yesnovar == n ]; then
	exit 0
elif [ $yesnovar == y ]; then
	echo -e "\nOutdated Versions"
	outdated=`brew outdated`
	echo $outdated
	if [ -z $outdated ]; then
		echo -e "\nNothing to upgrade"
		exit 0
	else
		echo -e "\nWould you like to upgrade outdated packages?"
		read -p '[y/n]: ' yesnovar
		if [ $yesnovar == n ]; then
			exit 0
		elif [ $yesnovar == y ]; then
			brew upgrade
		else 
			echo "Unknown Response $yesnovar"
			exit 1
		fi
	fi
else
	echo "Unknown Response $yesnovar"
	exit 1
fi
