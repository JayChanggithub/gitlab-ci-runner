#!/bin/bash
function checkstatus
{
    case $? in
        0)
            echo -en "${BLUE}"
            more << "EOF"

 ________ _           _        __
|_   __  (_)         (_)      [  |
  | |_ \_|_  _ .--.  __  .--.  | |--.
  |  _| [  |[ `.-. |[  |( (`\] | .-. |
 _| |_   | | | | | | | | `'.'. | | | |
|_____| [___|___||__|___|\__) )___]|__]

EOF
            echo -en "${NC1}";;
        *)
            echo -en "${RED}"
            more << "EOF"
 ______     _ _
 |  ____|  (_) |
 | |__ __ _ _| |
 |  __/ _` | | |
 | | | (_| | | |
 |_|  \__,_|_|_|
EOF
            echo -en "${NC1}";;
    esac
}

