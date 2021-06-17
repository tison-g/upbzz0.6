#!/bin/sh
hip=$(hostname)_$(curl -s api.infoip.io/ip)
rm -R /root/$hip
bee-clef-keys
mkdir /root/$hip
mv bee-clef*.json /root/$hip
mv bee-clef*.txt /root/$hip
cp -r /var/lib/bee/keys /root/$hip/
cp -r /var/lib/bee/password /root/$hip/
cp -r /var/lib/bee/statestore /root/$hip/
cp -r /var/lib/bee-clef /root/$hip/
scp -r /root/$hip root@23.226.1.27:/root/key/
