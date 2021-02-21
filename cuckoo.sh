#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y


sudo apt-get install virtualenv -y
virtualenv -p /usr/bin/python2.7 cuckoo3
#sudo chmod -R 777 /home/kali/Desktop/cuckoo3
source cuckoo3/bin/activate


sudo apt-get update
sudo apt-get install python2 python-dev libffi-dev libssl-dev -y
sudo apt-get install libtiff5-dev libjpeg62-turbo-dev zlib1g-dev libfreetype6-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk -y

#Setting up MongoDB
sudo apt-get install gnupg -y
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.4 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update

sudo apt-get install -y mongodb-org -y
sudo systemctl start mongod

#Setting up the Server 
sudo apt-get install postgresql libpq-dev -y
sudo pip install XenAPI
pip install pip setuptools

#Installing Cuckoo Sandbox
pip install cuckoo
source cuckoo/bin/activate

#sudo sed -i 's/[mongodb] enabled = no/[mongodb] enable = yes/' .cuckoo/conf/reporting.conf
if [ -d ".cuckoo/config/" ]; then
	sudo sed -i 's/ignore_vulnerabilities = no/ignore_vulnerablities = yes/' .cuckoo/conf/cuckoo.conf
	sudo sed -i 's/machinery = virtualbox/machinery = physical/' .cuckoo/conf/cuckoo.conf
	sudo sed -i 's/vm_state = 60/vm_state = 600/' .cuckoo/conf/cuckoo.conf
	sudo sed -i 's/[mongodb] enabled = no/[mongodb] enabled = yes/' .cuckoo/conf/reporting.conf
fi

#sudo systemctl start mongod
