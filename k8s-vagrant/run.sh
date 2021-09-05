#!/usr/bin/env bash

set -euo pipefail

function connect() {
  ssh student@192.168.56.101
}

function up(){
  vagrant up worker | tee ./worker.log   
  vagrant up master | tee ./master.log
}

function suspend(){
  vagrant suspend master worker    
}

function resume(){
  vagrant resume master worker    
}

function help(){
  echo "Usage:
    connect - login to master node
    help - Print help
    suspend - suspend vms
    resume - resume vms
    up - start vms
    "
}

function execute(){
  if [ "$#" == "0" ]; then
    help
    exit 1
  fi
  readonly command=${1:-''}
  shift
  case "$command" in
    connect)
      $command "$@"
      ;;  
    up)
      $command "$@" | tee ./master.out
      ;;
    suspend)
      $command
      ;;
    resume)
      $command
      ;;
    help)
      $command
      ;;    
    *)
      echo "Unrecognized command: '$command'"
      help
      ;;
  esac
}

execute "$@"