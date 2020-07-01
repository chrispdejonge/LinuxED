#!/bin/bash
sudo apt install -y autoconf bc gawk dc build-essential gcc libc6 make wget unzip apache2 php libapache2-mod-php7.2 libgd-dev libmcrypt-dev make libssl-dev snmp libnet-snmp-perl gettext
cd ~/
wget https://github.com/NagiosEnterprises/nagioscore/releases/download/nagios-4.4.6/nagios-4.4.6.tar.gz
tar xzf nagios-4.4.6.tar.gz
cd nagios-4.4.6
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
sudo make all
sudo make install-groups-users
sudo usermod -a -G nagios www-data
sudo make install
sudo make install-daemoninit
sudo make install-commandmode
sudo make install-config
sudo make install-webconf
sudo a2enmod rewrite cgi
sudo systemctl restart apache2
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
sudo ufw allow Apache
sudo ufw reload
sudo apt install nagios-plugins nagios-nrpe-plugin -y
cd /usr/local/nagios/etc
sudo sed -i 's/#\(.*cfg_.*servers.*\)/\1/' nagios.cfg
sudo mkdir -p /usr/local/nagios/etc/servers
cd /usr/local/nagios/etc/
sudo sed -i 's/^\(\$USER1\$\s*=\s*\).*$/\$USER1\$=\/usr\/lib\/nagios\/plugins/' resource.cfg
cd /usr/local/nagios/etc/objects
sudo chmod 777 commands.cfg
sudo printf "\ndefine command{
        command_name check_nrpe
        command_line \$USER1\$/check_nrpe -H \$HOSTADDRESS\$ -c \$ARG1\$
}" >> commands.cfg
sudo systemctl start nagios
sudo systemctl enable nagios
sudo systemctl restart apache2
sudo systemctl status nagios
