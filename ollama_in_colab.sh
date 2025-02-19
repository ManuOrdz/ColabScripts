#!/bin/bash
#Script to automatize the ollama install and pull some models

function install_ollama() {
  echo "Installing Ollama"
  curl -fsSL https://ollama.com/install.sh | sh
  ollama -v
}

function download_model() {
  ollama serve &
  ollama pull ${1}
}

##
#Color variables
##

green='\e[32m'
blue='\e[34m'
red='\e[31m'
clear='\e[0m'

##
#Color function
##

ColorGreen() {
  echo -ne $green$1$clear
}

ColorBlue() {
  echo -ne $blue$1$clear
}

ColorRed() {
  echo -ne $red$1$clear
}

menu() {
  echo -ne "
Menu
$(ColorGreen '1)') Install Ollama
$(ColorGreen '2)') Download models
$(ColorGreen '0)') exit
$(ColorBlue 'Please choose an option:')
"
  read a
  case ${a} in
  1)
    install_ollama
    menu
    ;;
  2)
    read -p "What model do you want to download?: " model
    echo ""
    download_model ${model}
    menu
    ;;
  0) exit ;;
  *)
    echo -e $red"Wrong option"$clear
    ;;
  esac
}

menu
