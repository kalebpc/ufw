#!/bin/bash

#ufw install and configuration
apt-get install ufw -y
#ufw reset
yes | ufw reset

ufw enable

ufw default deny incoming
ufw default deny outgoing
ufw default deny forward

main_interface=$(ip route get 8.8.8.8 | awk -- '{printf $5}')
ufw allow out on $main_interface to 1.1.1.1 proto udp port 53 comment 'allow DNS'
ufw allow out on $main_interface to any proto tcp port 80 comment 'allow HTTP'
ufw allow out on $main_interface to any proto tcp port 443 comment 'allow HTTPS'

ufw status numbered
echo "Done"
