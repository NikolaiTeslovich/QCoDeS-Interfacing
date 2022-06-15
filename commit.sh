#!/bin/bash
# Automate a git commit, saving the user several steps

#define colors for colored text
green=`tput setaf 2`
reset=`tput sgr0`

git add .

echo "commit message:"
read message

git commit -m '${message}'

git push

clear

echo "${green}pushed successfully!${reset}"
