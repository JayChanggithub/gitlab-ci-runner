#!/bin/bash
function dockerinfo
{
    local count=0
    local git_ip='10.99.104.242'

    # check runner image
    printf "${BLUE} %s ${NC1} \n" "${line}check runner images${line}"
    if [ $(docker images | grep -ci "$image:$version") -eq 0 ]; then
        echo Bs-VGxAU-EDXpVXRiVww | \
        docker login -u iec070781 registry.ipt-gitlab:8081  --password-stdin
        docker pull $image:$version || docker pull gitlab/gitlab-runner:v11.3.1
    else
        printf "${BLUE} %s ${NC1} \n" "${line}gitlab-runner image exist.${line}"
    fi

    # check docker-compose
    printf "${BLUE} %s ${NC1} \n" "${line}check docker compose${line}"
    if [ -f /usr/local/bin/docker-compose -a "$(command -v docker-compose)" != "" ]; then
        printf "${BLUE} %s ${NC1} \n" "${line}docker-compose exist.${line}"
    else
        curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) \
             -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose
        if [ "$(command -v docker-compose)" != "" ]; then
            printf "${BLUE} %s ${NC1} \n"  "${line}docker-compose install success.$line"
        else
            printf "${RED} %s ${NC1} \n" "${line}install docker-compose something wrong.${line}"
            exit 1
        fi
    fi

    # check gitlab connection
    printf "${BLUE} %s ${NC1} \n" "${line}check gitlab server whether connection.${line}"

    while true
    do
        ping $git_ip -c 1 -q > /dev/null 2>&1
        case $? in
            0)
                printf "${BLUE} %s ${NC1} \n" "connection gitlab server success."
                return 0;;
            *)
                # check fail count
                if [ $count -ge 4 ]; then
                    printf "${RED} %s ${NC1} \n" "connection gitlab server fail."
                    exit 1
                fi;;
        esac
        count=$(( count + 1 ))
    done
}
