#!/bin/bash

function err(){
  RED='\033[0;31m'
  NC='\033[0m'
  echo -e "${RED}Error: ${*} ${NC}" >>/dev/stderr
}

# Expects base url as 1st arg
function get_latest_release() {
  export RELEASE=$(curl -s "$1"/releases/latest | grep -oE '[0-9]{1,\}.[0-9]{1,\}.[0-9]{1,\}')
  if [ "$RELEASE" == "" ]
  then
    err "Failed parse version out of URL redirect."
    return 1
  else
    echo "Updating to version: $RELEASE"
    return 0
  fi
}

# Expects $1 as path to file.
function make_executable() {
  echo "Making $1 executable by all $USER"

  sudo chown "$USER":"$USER" "$1" && sudo chmod 0755 "$1"
}