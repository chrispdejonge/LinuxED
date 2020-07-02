docker installation:
 cmd.run:
   - name: |
        sudo apt install docker.io -y
        sudo systemctl start docker
        sudo systemctl enable docker