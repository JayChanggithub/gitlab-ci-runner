#!/bin/bash
function updatehost
{
    if [ $(cat /etc/hosts | egrep -co "$1") -ne 2 ]; then
        tee -a /etc/hosts << EOF
$1    registry.ipt-gitlab
$2    ipt-gitlab.ies.inventec
EOF
    else
        printf "${BLUE} %s ${NC1} \n" "config:/etc/hosts already exist."
    fi
    return 0
}
