#!/bin/bash
#Script to automatize the ollama install and pull some models

#########################################
#Description: Download model from ollama
#Globals:
# None
#Arguments:
# Model Name
#Outputs:
# List of models installed
#Returns:
# 0 if successful, none-zero on error
#########################################
function download_model() {
  ollama pull $1
}

#Verify if ollama is install
if ! which ollama >/dev/null; then
  echo "ollama could no be found"
  echo "Installing ollama"
  curl -fsSL https://ollama.com/install.sh | sh
  echo "Installing ollama successfull"
else
  echo "ollama already installed"
  echo "running ollama"
  ollama serve &
  echo ""
  sleep 1
  read -p "What model do you want to download: " model
  download_model $model
fi
