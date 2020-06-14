#!/bin/bash
function setrunner
{
    if [ -f /srv/gitlab-runner/config/config.toml ]; then
        rm -rf /srv/gitlab-runner/config/*
    fi
    printf "${BLUE} %s ${NC1} \n" "${line}Setup registered the gitlab-runner$line"
    docker run --rm -it -v /srv/gitlab-runner/config:/etc/gitlab-runner \
        --name gitlab-runner gitlab/gitlab-runner register \
        --non-interactive \
        --executor "docker" \
        --docker-image docker:18 \
        --url "$1" \
        --registration-token "$2" \
        --description "general-runner" \
        --tag-list "$4" \
        --run-untagged \
        --locked="false"
    if [ $? -eq 0 ]; then
        if [ -f /srv/gitlab-runner/config/config.toml ]; then
            sed -i.bak 's,concurrent\ =\ 1,concurrent\ =\ 10,g' /srv/gitlab-runner/config/config.toml
            sed -i.bak 's,session_timeout\ =\ 1800,session_timeout\ =\ 86400,g' /srv/gitlab-runner/config/config.toml
            sed -i.bak "15 a\    extra_hosts = [\"ipt-gitlab:"$3"\"]" /srv/gitlab-runner/config/config.toml
            sed -i.bak "16 a\    pull_policy = \"if-not-present\""   /srv/gitlab-runner/config/config.toml
            sed -i.bak 's,volumes\ =\ \[\"\/cache\"\],volumes\ =\ \[\"\/var\/run\/docker\.sock\:\/var\/run\/docker\.sock\"\,\"\/etc\/hosts\:\/etc\/hosts\:ro\"\,\"\/cache\"\],g' /srv/gitlab-runner/config/config.toml
        fi

        if [ $(docker images | grep -coi "$image:$version") -ne 0 ]; then
            docker run -d --name gitlab-runner --restart always \
                       -v /var/run/docker.sock:/var/run/docker.sock \
                       -v /srv/gitlab-runner/config:/etc/gitlab-runner \
                       -v /etc/hosts:/etc/hosts:ro \
                       $image:$version
        else
            docker run -d --name gitlab-runner --restart always \
                       -v /var/run/docker.sock:/var/run/docker.sock \
                       -v /srv/gitlab-runner/config:/etc/gitlab-runner \
                       -v /etc/hosts:/etc/hosts:ro \
                       gitlab/gitlab-runner:v11.3.1
        fi
    else
        printf "${RED} %s ${NC1} \n" "registered gitlab function invaild. please check it."
        return 1
    fi
}


