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
	count=${outdated} | wc -l
	echo "${outdated}"
	if [ ${count} > 0 ]; then
		echo -e "\nWould you like to upgrade outdated packages?"
		read -p '[y/n]: ' yesnovar
		if [ $yesnovar == n ]; then
			exit
		elif [ $yesnovar == y ]; then
			brew upgrade
		else 
			echo "Unknown Response $yesnovar"
			exit 1
		fi
	else
		echo -e "Nothing to upgrade"
		exit
	fi
else
	echo "Unknown Response $yesnovar"
	exit 1
fi
