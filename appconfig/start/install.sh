#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR


# get the path to this script
APP_PATH=`dirname "$0"`
APP_PATH=`( cd "$APP_PATH" && pwd )`

unattended=0
subinstall_params=""
for param in "$@"
do
  echo $param
  if [ $param="--unattended" ]; then
    echo "installing in unattended mode"
    unattended=1
    subinstall_params="--unattended"
  fi
done

default=y
while true; do
  if [[ "$unattended" == "1" ]]
  then
    resp=$default
  else
    [[ -t 0 ]] && { read -t 10 -n 2 -p $'\e[1;32mInstall Main Libs? [y/n] (default: '"$default"$')\e[0m\n' resp || resp=$default ; }
  fi
  response=`echo $resp | sed -r 's/(.*)$/\1=/'`

  if [[ $response =~ ^(y|Y)=$ ]]
  then

    toilet Installing main Libs

    # essentials
    sudo apt-get -y install tig cmake cmake-curses-gui build-essential automake autoconf autogen libncurses5-dev libc++-dev pkg-config libtool net-tools openssh-server nmap

    #sudo apt -y install pkg-config  net-tools openssh-server g++-12

    #sudo apt -y install vim-nox
    #sudo apt -y install mono-complete golang nodejs openjdk-17-jdk openjdk-17-jre

    # python
    sudo apt update #&& sudo apt upgrade
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt install python3.9
    sudo apt install python3.8

    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.9 2
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 3

    sudo update-alternatives --config python

    sudo apt -y install python3-git

    sudo apt -y install python3-serial python3-dev python-setuptools python3-setuptools python3-pip
 
    # other stuff
    sudo apt -y install ruby gem tree exfat-fuse blueman autossh wget snapd
    sudo apt -y install sl indicator-multiload figlet exuberant-ctags xclip xsel exfatprogs jq xvfb gparted espeak ncdu

break
  elif [[ $response =~ ^(n|N)=$ ]]
  then
    break
  else
    echo " What? \"$resp\" is not a correct answer. Try y+Enter."
  fi
done
