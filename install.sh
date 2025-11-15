#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

# define paths
APPCONFIG_PATH=$MY_PATH/appconfig

# install packages
sudo apt-get -y update

subinstall_params=""
unattended=0
docker=false
for param in "$@"
do
  echo $param
  if [ $param="--unattended" ]; then
    echo "installing in unattended mode"
    unattended=1
    subinstall_params="--unattended"
  fi
done

cd $MY_PATH
git submodule update --init --recursive --recommend-shallow

arch=`uname -i`

if [ "$unattended" == "0" ]
then
  if [ "$?" != "0" ]; then echo "Press Enter to continues.." && read; fi
fi

# Installing Main Libs
#bash $APPCONFIG_PATH/start/install.sh $subinstall_params

# install DOLPHIN File Manager
bash $APPCONFIG_PATH/dolphin/install.sh $subinstall_params
sudo cp $APPCONFIG_PATH/dolphin/*.desktop /usr/share/kservices5

# install GOOGLE CHROME
bash $APPCONFIG_PATH/chrome/install.sh $subinstall_params

# install SUBLIME
bash $APPCONFIG_PATH/sublime/install.sh $subinstall_params

3# install TWEAK
bash $APPCONFIG_PATH/tweak/install.sh $subinstall_params

# install MY TOOLS
#bash $APPCONFIG_PATH/tools/install.sh $subinstall_params

# install ZOOM
#bash $APPCONFIG_PATH/zoom/install.sh $subinstall_params

# install TEAMS
#bash $APPCONFIG_PATH/teams/install.sh $subinstall_params

sudo apt remove hijra-applet
sudo apt purge hijra-applet

# finally source the correct rc file
toilet All Done

# say some tips to the new user
echo "Hurray, the 'Linux Setup Extras' should be ready, try opening a new terminal."
