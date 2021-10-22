#!/usr/bin/env bash

set -euo pipefail

function ssh_master() {
  ssh vagrant@192.168.56.101 -i .vagrant/machines/master/virtualbox/private_key
}

function ssh_worker() {
  ssh vagrant@192.168.56.104 -i .vagrant/machines/worker/virtualbox/private_key
}

function up(){
  vagrant up worker | tee ./worker.log   
  vagrant up master | tee ./master.log
  vagrant ssh-config
}

function suspend(){
  vagrant suspend master worker    
}

function resume(){
  vagrant resume master worker    
}

function help(){
  echo "Usage:
    ssh_master - login to master node
    ssh_worker
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
    ssh_master)
      $command "$@"
      ;;
    ssh_worker)
      $command "$@"
      ;;  
    up)
      $command "$@"
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