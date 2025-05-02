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

# Tüm etkileşimli ekranları otomatik atla
export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

echo "🧩 Aztec Sequencer Node Kurulumu Başlıyor"

# 1. Sistem güncellemeleri
sudo apt-get update && sudo apt-get upgrade -y

# 2. Gerekli paketlerin kurulumu
sudo apt install curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev -y

# 3. Docker kurulumu
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove -y $pkg; done

sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y && sudo apt upgrade -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Docker test ve başlatma
sudo docker run hello-world
sudo systemctl enable docker
sudo systemctl restart docker

# 4. Aztec CLI kurulumu
bash -i <(curl -s https://install.aztec.network)
source ~/.bashrc

# 5. Aztec testnet yapılandırması
aztec-up alpha-testnet

# 6. Gerekli portların açılması
ufw allow 22
ufw allow ssh
ufw allow 40400
ufw allow 8080
ufw enable

# 7. Kullanıcıdan veri alma
read -p "🔗 L1 RPC URL'nizi girin: " RPC_URL
read -p "🔑 Metamask özel anahtarınızı girin: " PRIVATE_KEY
read -p "📬 Metamask public adresinizi girin: " COINBASE
read -p "🌐 Sunucu dış IP adresinizi girin: " IP_ADDR

# 8. Aztec node başlatma komutu
START_COMMAND="aztec start --node --archiver --sequencer \
  --network alpha-testnet \
  --l1-rpc-urls $RPC_URL \
  --l1-consensus-host-urls https://rpc.drpc.org/eth/sepolia/beacon \
  --sequencer.validatorPrivateKey $PRIVATE_KEY \
  --sequencer.coinbase $COINBASE \
  --p2p.p2pIp $IP_ADDR"

# 9. Screen içinde başlat
screen -dmS aztec bash -c "$START_COMMAND"

# 10. Bilgilendirme
echo "✅ Aztec node 'aztec' isimli screen içinde başlatıldı."
echo "🔍 İzlemek için: screen -r aztec"
