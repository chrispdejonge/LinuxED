install_syslog-ng:
  pkg.installed:
    - pkgs:
      - syslog-ng
      - syslog-ng-core
 
copy syslog-ng.conf:
 file.copy:
 - name: /etc/syslog-ng/syslog-ng.conf
 - source: /home/chris/LinuxED/SYMinion.conf
 - force: True
 
set host ip:
 file.replace:
 - name: /etc/syslog-ng/syslog-ng.conf
 - pattern: HOST_IP
 - repl: {{ grains['master'] }}
 
restart syslog-ng:
 cmd:
 - run
 - name: systemctl restart syslog-ng
