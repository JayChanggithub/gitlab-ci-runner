#!/bin/bash
function dockerservice
{
    if [ "$(command -v docker)" != "" ]; then
        printf "${BLUE} %s ${NC1} \n" "docker engine already installation."
    else
        printf "${RED} %s ${NC1} \n" "start installed the Docker engine."
        yum install -y yum-utils device-mapper-persistent-data lvm2
        yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo
        yum-config-manager --enable docker-ce-edge
        yum makecache fast
        yum install -y docker-ce
        systemctl enable docker.service
        systemctl start docker.service
        if [ $? -ne 0 ]; then
            yum --enablerepo=epel install docker-ce -y
            systemctl enable docker.service
            systemctl start docker.service
        fi
    fi
    printf "${BLUE} %s ${NC1} \n" "${line}Setup the /etc/docker/daemon.json${line}"

    # setup docker configuration
    tee /etc/docker/daemon.json << EOF
{
    "bip": "172.27.0.1/16",
    "dns": ["10.99.2.59","10.99.6.60"],
    "insecure-registries":["$rigistry_server"],
    "live-restore": true,
    "exec-opts": ["native.cgroupdriver=systemd"],
    "log-driver": "json-file",
    "max-concurrent-downloads": 6,
    "log-opts": {
        "max-size": "10k",
        "max-file": "3"
    }
}
EOF
    systemctl daemon-reload
    systemctl restart docker.service

    if [ $? -ne 0 ]; then
        printf "${RED} %s ${NC1} \n" "docker service failed."
        exit 1
    fi
    return 0
}
