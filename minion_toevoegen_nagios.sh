#!/bin/bash

read -p "Naam Minion?: " remote_host
read -p "Ip address Minion?: " remote_host_ip
cd "/usr/local/nagios/etc/servers/"
sudo bash -c "cat << EOF > /usr/local/nagios/etc/servers/'$remote_host.cfg'

#Ubuntu Host configuration file
define host {
        use                          linux-server
        host_name                    $remote_host
        alias                        $remote_host
        address                      $remote_host_ip
        register                     1
}
define service{                                                
            use                     local-service           
            host_name               ubuntu-nagios-client          
            service_description     SWAP Uasge           
            check_command           check_nrpe!check_swap                          
                               
}                                   
                                  
define service{                                                
            use                     local-service           
            host_name               ubuntu-nagios-client           
            service_description     Root / Partition           
            check_command           check_nrpe!check_root                         
                                
}                                 
                               
define service{            
            use                     local-service           
            host_name               ubuntu-nagios-client           
            service_description     Current Users           
            check_command           check_nrpe!check_users                                       
}                                  
                             
define service{                                                    
            use                     local-service           
            host_name               ubuntu-nagios-client          
            service_description     Total Processes           
            check_command           check_nrpe!check_total_procs                              
}                                  
                                
define service{              
            use                     local-service           
            host_name               ubuntu-nagios-client           
            service_description     Current Load           
            check_command           check_nrpe!check_load
}
EOF"

sudo systemctl restart nagios
