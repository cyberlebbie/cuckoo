#!/bin/bash

########################################################################
## This codes automates the installation of cuckoo sandbox.           ##
## It was writing by Mohamed Lebbie.                                  ##
########################################################################

#Updating the system
sudo apt-get update && sudo apt-get upgrade -y

#Installing Virtual Environment
sudo apt-get install virtualenv -y
virtualenv -p /usr/bin/python2.7 cuckoo
source cuckoo/bin/activate
sudo apt-get update

#Installing Cuckoo Dependencies
sudo apt-get install python2 python2-minimal libffi-dev libssl-dev -y #Updated (1st Aug 2023)
sudo apt-get install libtiff5-dev libjpeg62-turbo-dev zlib1g-dev libfreetype6-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk -y

#Setting up MongoDB
sudo apt-get install gnupg -y
wget -qO - https://www.mongodb.org/static/pgp/server-7.0.asc | sudo apt-key add -
echo "deb http://repo.mongodb.org/apt/debian/dists/buster/mongodb-org/7.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
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

#Basic Configuration of cuckoo
if [ -d ".cuckoo/config/" ]; then
	sudo sed -i 's/ignore_vulnerabilities = no/ignore_vulnerablities = yes/' .cuckoo/conf/cuckoo.conf
#Set the machinery to physical which will allow cuckoo to connect to an actual physical system
	sudo sed -i 's/machinery = virtualbox/machinery = physical/' .cuckoo/conf/cuckoo.conf
#Increase the wait time for response from the guest PC
	sudo sed -i 's/vm_state = 60/vm_state = 600/' .cuckoo/conf/cuckoo.conf
#Enable mongodb to allow access to the cuckoo sandbox via web interface
	sudo sed -i 's/[mongodb] enabled = no/[mongodb] enabled = yes/' .cuckoo/conf/reporting.conf
fi
