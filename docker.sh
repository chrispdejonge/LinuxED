#! /bin/bash

#Uninstall old versions if exists
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update
#Set up the Docker repositories
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

#Add the official Docker GPG keys
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#Verify the key fingerprint
sudo apt-key fingerprint 0EBFCD88

#Install Docker CE on your instance
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

#Test if docker working fine 
sudo docker run hello-world

#Docker version 
docker -v

#Check images on your system
sudo docker images