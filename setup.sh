#!/bin/bash

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg postgresql gufw gh openssh-server
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker run hello-world

sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
sudo usermod -aG nordvpn $USER
nordvpn set analytics 0 && nordvpn set technology OpenVPN && nordvpn set protocol tcp && nordvpn set autoconnect 1 && nordvpn set notify 1 && nordvpn set lan-discovery 1 && nordvpn set threatprotectionlite 1 && nordvpn set killswitch 1

echo '#!/bin/bash 
ssh -p 5163 tate@tate-server.ddns.net' > /usr/bin/tate-server
echo '#!/bin/bash 
ssh -p 5163 tate@our-host.ddns.net' > /usr/bin/our-host

echo '#!/bin/bash
docker stop $(docker ps -a -q)' > /usr/bin/d-stopall
echo '#!/bin/bash
docker rm $(docker ps -a -q)' > /usr/bin/d-stopall

sudo chmod +x /usr/bin/d-stopall
sudo chmod +x /usr/bin/d-rmall

sudo chmod +x /usr/bin/tate-server
sudo chmod +x /usr/bin/our-host
