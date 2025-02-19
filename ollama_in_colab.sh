#!/bin/bash
#Script to automatize the ollama install and pull some models

#Verify if ollama is install
if ! which ollama >/dev/null; then
  echo "ollama could no be found"
  curl -fsSL https://ollama.com/install.sh | sh
else
  echo "ollama already installed"
  echo "running ollama"
  ollama serve &
  ollama pull deepseek-r1:14b
  ollama pull nomic-embed-text
fi
