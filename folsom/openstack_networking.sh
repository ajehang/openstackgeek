#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "You need to be 'root' dude." 1>&2
   exit 1
fi

# bridge stuff
apt-get install vlan bridge-utils -y

# kvm
apt-get install lxc libvirt-bin pm-utils -y

# install time server
apt-get install ntp -y
service ntp restart

# modify timeserver configuration
sed -e "
/^server ntp.ubuntu.com/i server 127.127.1.0
/^server ntp.ubuntu.com/i fudge 127.127.1.0 stratum 10
/^server ntp.ubuntu.com/s/^.*$/server ntp.ubutu.com iburst/;
" -i /etc/ntp.conf

# turn on forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

echo;
echo "#################################################################################################

Go and edit your /etc/network/interfaces file to look something like this:

auto eth0
 iface eth0 inet dhcp                    
 # Bridge network interface for VM networks
 auto br100 
 iface br100 inet static 
 address 192.168.100.1 
 netmask 255.255.255.0 
 bridge_stp off 
 bridge_fd 0

After you are done, do a '/etc/init.d/networking restart', then run ''

#################################################################################################
"


exit
