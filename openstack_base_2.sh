#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "You need to be 'root' dude." 1>&2
   exit 1
fi

# bridge stuff
apt-get install bridge-utils
sudo brctl addbr br100
sudo /etc/init.d/networking restart

# rabbit food
apt-get install rabbitmq-server memcached python-memcache

# kvm
apt-get install kvm libvirt-bin

echo "#################################################################################################
 next ./openstack_mysql.sh
"

exit
