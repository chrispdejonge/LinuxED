Make sure wordpress is installed:
  pkg.installed:
    - pkgs:
      - wordpress
      - php
      - libapache2-mod-php
      - mysql-server
      - php-mysql

Configuring wordpress:
  file.managed:
    - name: /etc/apache2/sites-available/wordpress.conf
    - source: salt://wordpress.conf

Database setup:
  file.managed:
    - name: /etc/wordpress/config-localhost.php
    - source: salt://wordpress.php

Start mysql service:
  service.running:
    - name: mysql