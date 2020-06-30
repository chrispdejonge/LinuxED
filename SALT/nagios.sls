add_nagios_client:
  pkg.installed:
  - pkgs:
    - nagios-nrpe-server
    - nagios-plugins
    
uncomment line:
 file.uncomment:
  - name: /etc/nagios/nrpe.cfg
  - regex: server_address=*

replace line:
 file.replace:
  - name: /etc/nagios/nrpe.cfg
  - pattern: server_address=127.0.0.1
  - repl: server_address={{ grains['master'] }}

restart nrpe:
  service.running:
    - name: nagios-nrpe-server
    - enable: True
    - restart: True
