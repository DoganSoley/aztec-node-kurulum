#!/bin/bash

# Renk kodları
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 8. CRYPTOLOSS
echo " "
echo " "
echo " "
echo -e "${BLUE} ######  ########  ##    ## ########  ########  #######  ##        #######   ######   ######${NC}"
echo -e "${BLUE}##    ## ##     ##  ##  ##  ##     ##    ##    ##     ## ##       ##     ## ##    ## ##    ##${NC}"
echo -e "${BLUE}##       ##     ##   ####   ##     ##    ##    ##     ## ##       ##     ## ##       ##${NC}"
echo -e "${BLUE}##       ########     ##    ########     ##    ##     ## ##       ##     ##  ######   ######${NC}"
echo -e "${BLUE}##       ##   ##      ##    ##           ##    ##     ## ##       ##     ##       ##       ##${NC}"
echo -e "${BLUE}##    ## ##    ##     ##    ##           ##    ##     ## ##       ##     ## ##    ## ##    ##${NC}"
echo -e "${BLUE} ######  ##     ##    ##    ##           ##     #######  ########  #######   ######   ######${NC}"
echo " "
echo " "
echo " "
echo " "

# Aztec Sequencer Node Setup Script (automated)

echo "🧩 Aztec Sequencer Node Kurulumu Başlıyor"

# 1. Sistem güncellemeleri
sudo apt-get update && sudo apt-get upgrade -y

# 2. Gerekli paketlerin kurulumu
sudo apt install curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev -y

# 3. Docker kurulumu
sudo apt update -y && sudo apt upgrade -y
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y && sudo apt upgrade -y

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Test Docker
sudo docker run hello-world

sudo systemctl enable docker
sudo systemctl restart docker

# 4. Aztec CLI kurulumu
bash -i <(curl -s https://install.aztec.network)

echo " "
echo " "
echo " "
echo -e "${BLUE} ######  ########  ##    ## ########  ########  #######  ##        #######   ######   ######${NC}"
echo -e "${BLUE}##    ## ##     ##  ##  ##  ##     ##    ##    ##     ## ##       ##     ## ##    ## ##    ##${NC}"
echo -e "${BLUE}##       ##     ##   ####   ##     ##    ##    ##     ## ##       ##     ## ##       ##${NC}"
echo -e "${BLUE}##       ########     ##    ########     ##    ##     ## ##       ##     ##  ######   ######${NC}"
echo -e "${BLUE}##       ##   ##      ##    ##           ##    ##     ## ##       ##     ##       ##       ##${NC}"
echo -e "${BLUE}##    ## ##    ##     ##    ##           ##    ##     ## ##       ##     ## ##    ## ##    ##${NC}"
echo -e "${BLUE} ######  ##     ##    ##    ##           ##     #######  ########  #######   ######   ######${NC}"
echo " "
echo " "
echo " "
echo " "

Sunucuya tekrar bağlanın..

exit
