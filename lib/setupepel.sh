#!/bin/bash
function setupepel
{
    local plug_file="/etc/yum.repos.d/CentOS-Base.repo"
    local epel_file="/etc/yum.repos.d/epel.repo"
    for pkg in  "yum-plugin-priorities" "epel-release"
    do
        case "$pkg" in
            "yum-plugin-priorities")
                yum install -y $pkg
                if [ -f $plug_file ]; then
                    sed -i "s/\]$/\]\npriority=1/g" $plug_file
                else
                    "${RED} %s %s %s ${NC1} \n" "$plug_file" "=>" "not found."
                    return 1
                fi;;
            "epel-release")
                yum install -y $pkg
                if [ -f $epel_file ]; then
                    sed -i "s/\]$/\]\npriority=5/g" $epel_file
                    sed -i "s/enabled=1/enabled=0/g" $epel_file
                else
                    print "${RED} %s %s %s ${NC1} \n" "$epel_file" "=>" "not found."
                    return 1
                fi;;
        esac
    done
    return 0
}

