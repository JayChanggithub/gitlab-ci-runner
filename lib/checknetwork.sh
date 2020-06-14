#!/bin/bash
function checknetwork
{
    local count=0
    local network=$1
    local USERNAME='admin'
    local PASSWORD='ZD7EdEpF9qCYpDpu'
    local proxy="http://${USERNAME}:${PASSWORD}@10.99.104.251:8081/"
    while true
    do
        if [ "$(command -v curl)" == "" ]; then
            ping $network -c 1 -q > /dev/null 2>&1
        else
            curl $network -c 1 -q > /dev/null 2>&1
        fi
        case $? in
            0)
                printf "${BLUE} %s ${NC1} \n" "network success."
                return 0;;
            *)
                export {https,http}_proxy=$proxy

                # check fail count
                if [ $count -ge 4 ]; then
                    printf "${RED} %s ${NC1} \n" "network disconnection."
                    exit 1
                fi;;
        esac
        count=$(( count + 1 ))
    done
}
