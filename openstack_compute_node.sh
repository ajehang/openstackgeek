#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "You need to be 'root' dude." 1>&2
   exit 1
fi

# install mysql client
apt-get install mysql-client

#install nova network nova compute nova client
apt-get install python-novaclient nova-network nova-compute