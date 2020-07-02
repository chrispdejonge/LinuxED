#!/bin/bash

sudo apt install apache2 -y
sudo systemctl restart apache2.service
sudo systemctl enable apache2.service

sudo apt install wordpress php libapache2-mod-php mysql-server php-mysql -y

sudo systemctl restart mysql.service
sudo systemctl enable mysql.service
   
cd /etc/apache2/sites-available
sudo touch wordpress.conf
sudo chmod 777 wordpress.conf
sudo printf "Alias /blog /usr/share/wordpress
<Directory /usr/share/wordpress>
    Options FollowSymLinks
    AllowOverride Limit Options FileInfo
    DirectoryIndex index.php
    Order allow,deny
    Allow from all
</Directory>
<Directory /usr/share/wordpress/wp-content>
    Options FollowSymLinks
    Order allow,deny
    Allow from all
</Directory>" >> wordpress.conf
   
sudo a2ensite wordpress 
sudo a2enmod rewrite
sudo service apache2 reload
   

mysql -u root <<QUERY_INPUT
CREATE DATABASE $dbnaam;  
GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' IDENTIFIED BY 'root';  
FLUSH PRIVILEGES;  
EXIT  
QUERY_INPUT
   
   
cd /etc/wordpress
   
sudo printf "<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'wordpress');
define('DB_PASSWORD', 'root');
define('DB_HOST', 'localhost');
define('DB_COLLATE', 'utf8_general_ci');
define('WP_CONTENT_DIR', '/usr/share/wordpress/wp-content');
?>" >> config-localhost.php

sudo service mysql start

cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
sudo cp -R wordpress /var/www/html
sudo chown -R www-data:www-data /var/www/html/wordpress/
sudo chmod -R 755 /var/www/html/wordpress/
sudo mkdir /var/www/html/wordpress/wp-content/uploads
sudo chown -R www-data:www-data /var/www/html/wordpress/wp-content/uploads/
 
sudo systemctl restart apache2
sudo systemctl restart mysql