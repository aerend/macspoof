#!/usr/bin/env bash

# assumes wifi card is en0
DEVICE=en0

# disconnect from all wifi networks
sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport --disassociate

# save old mac address
OLDMACADDRESS=$(ifconfig ${DEVICE} | grep ether | awk '{print $2}')
echo "old mac address: $OLDMACADDRESS"

# generate a new mac address
# this address has to have an even first group
NEWMACADDRESS=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/./0/2; s/.$//')
echo "new mac address: $NEWMACADDRESS"

# set new mac address
sudo ifconfig en0 ether ${NEWMACADDRESS}

# reconnect to wifi networks
networksetup -detectnewhardware
