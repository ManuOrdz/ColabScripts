#!/bin/bash
#Script to automatize the ollama install and pull some models

function install_ollama() {
  echo "Installing Ollama"
  curl -fsSL https://ollama.com/install.sh | sh
  ollama -v
}

function download_model() {
  ollama pull $1
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
$(ColorGreen '3)') Download nomic-embed-text and qwen2.5:14b
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
    ollama serve &
    sleep 1
    read -p "What model do you want to download?: " model
    echo ""
    download_model $model
    menu
    ;;
  3)
    embed_model="nomic-embed-text"
    llm_model="qwen2.5:14b"
    download_model $embed_model
    download_model $llm_model
    menu
    ;;
  0) exit ;;
  *)
    echo -e $red"Wrong option"$clear
    ;;
  esac
}

menu
