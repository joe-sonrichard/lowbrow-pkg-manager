#!/bin/bash

function err(){
  RED='\033[0;31m'
  NC='\033[0m'
  echo -e "${RED}Error: ${*} ${NC}" >>/dev/stderr
}

# Expects base url as 1st arg
function get_latest_release() {
  URL="$1"/releases/latest
  # Try for version assuming it's has 3 parts (x.x.x)
  export RELEASE=$(curl -s "$URL" | grep -oE '[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}')
  if [ "$RELEASE" == "" ]
  then
    # Try for version assuming it has 2 parts (x.x)
    export RELEASE=$(curl -s "$URL" | grep -oE '[0-9]{1,3}.[0-9]{1,3}')
    if [ "$RELEASE" == "" ]
    then
      err "Failed parse version out of URL redirect." "$URL"
      return 1
    else
      echo "Updating to version: $RELEASE"
      return 0
    fi
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