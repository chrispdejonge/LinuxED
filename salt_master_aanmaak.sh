#! /bin/bash
cd /home/chris
sudo curl -L https://bootstrap.saltstack.com -o install_salt.sh
#sudo apt-get update
sudo sh install_salt.sh -M
sudo mkdir /srv/salt
cd "/home/chris/LinuxED/SALT/"
sudo cp * /srv/salt/
cd /home/chris/
read -p "Salt Master IP adres?: " Salt_Master
sudo sh install_salt.sh -A $Salt_Master
sudo service salt-minion stop
read -p "Naam minion deze machine?: " Salt_Minion
sleep 1
sudo rm -rf /etc/salt/minion_id
sudo touch /etc/salt/minion_id && sudo chmod 777 /etc/salt/minion_id
sudo printf "$Salt_Minion" > /etc/salt/minion_id
sudo service salt-minion start