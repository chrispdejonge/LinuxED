Make sure wordpress is installed:
 cmd.run:
   - name: |
              sudo git clone https://github.com/chrispdejonge/LinuxED && cd LinuxED && sudo chmod +x setup_wordpress.sh && sudo ./setup_wordpress.sh