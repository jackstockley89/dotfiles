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

wbrew=`which brew`
pvbrew=`brew list --versions`
file="/Users/jackstockley/repo/dotfiles/brew/Brewfile"
bundlelist=`brew bundle list --file=${file}`

## Install homebrew ##
echo -e "${bold}Checking brew is installed${normal}"

if [ ${wbrew} = "/usr/local/bin/brew" ]; 
then
	echo -e "${green}brew already installed${normal}"
	echo -e "location: ${wbrew}"
	echo -e "Current packages and versions installed:"
	echo -e "${pvbrew}\n"
else 
	echo -e "${red}brew missing${normal}"
	echo -e "${yellow}installing brew${normal}"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo -e "location: ${wbrew}"
fi

echo -e "${yellow}Would you like to list packages from Brewfile?${normal}"
read -p '[y/n]: ' yesnovar

## Install Brewfile ##
if [ ${yesnovar} = "y" ]; 
then
	echo -e "${bold}Checking for Brewfile${normal}"
	if [ -f ${file} ];
	then
		echo -e "${bundlelist}\n"
		echo -e "${yellow}Would you like to install packages from Brewfile?${normal}"
		read -p '[y/n]: ' yesnovar
		if [ ${yesnovar} = "y" ];
		then
			`brew bundle install --file=${file}`
			echo "${green}install completed${normal}"
			exit 0
		else
			echo -e "${green}exiting...${normal}"
			exit 0
		fi
	else
		echo -e "${red}File not found${normal}"
		echo -e "exiting..."
		exit 1
	fi
else
	echo -e "${green}exiting...${normal}"
	exit 0
fi
