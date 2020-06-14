#!/bin/bash
#  Author: Jay Chang
#  This script is used to setup the gitlab-ci runner

# import modules
chmod +x lib/*
. lib/set_variable.sh
. lib/checknetwork.sh
. lib/setupepel.sh
. lib/dockerservice.sh
. lib/dockerinfo.sh
. lib/updatehost.sh
. lib/setrunner.sh
. lib/checkstatus.sh

# Main
echo -en "${BLUE}"
more << "EOF"
   _____ _____ _______ _               ____         _____ _____    _____ ______ _______ _    _ _____
  / ____|_   _|__   __| |        /\   |  _ \       / ____|_   _|  / ____|  ____|__   __| |  | |  __ \
 | |  __  | |    | |  | |       /  \  | |_) |_____| |      | |   | (___ | |__     | |  | |  | | |__) |
 | | |_ | | |    | |  | |      / /\ \ |  _ <______| |      | |    \___ \|  __|    | |  | |  | |  ___/
 | |__| |_| |_   | |  | |____ / ____ \| |_) |     | |____ _| |_   ____) | |____   | |  | |__| | |
  \_____|_____|  |_|  |______/_/    \_\____/       \_____|_____| |_____/|______|  |_|   \____/|_|

EOF
echo -en "${NC1}"

# check network connect to internet
checknetwork www.google.com

# setup the yum repository
setupepel

# check docker service
dockerservice

# check docker information
dockerinfo

# input regarding the gitlab-ci arguments
read -p "Please Input Runner token =>:" Token
read -p "Please Input Gitlab URL   =>:" URL
read -p "Please Input Gitlab IP   =>:" IP
read -p "Please define the git-ci tag =>:" tag

# update the /etc/hosts
updatehost $IP $IP

# setup the gitlab runner service
setrunner $URL $Token $IP $tag

# check finally status
checkstatus

