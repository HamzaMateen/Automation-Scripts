#!/bin/sh
# ls /sys/class/net | grep "^w"

ssid=$1
password=$2

# echo "ssid: ${ssid}" "password: ${password}"

filename="01-network-manager-all_copy.yaml"
file_dir="/etc/netplan"
# echo $file_dir

# _ssid, _password in .yaml file
sed -e "s/\${_ssid}/${ssid}/" -e "s/\${_password}/${password}/" ${filename} > "01-network-manager-all.yaml"

mv -f "01-network-manager-all.yaml" "${file_dir}/01-network-manager-all.yaml"

sudo netplan apply
