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

# --------------------------
# SİSTEM GÜNCELLEMELERİ VE GEREKLİ PAKETLER
# --------------------------

echo "🚀 Sistem güncelleniyor ve temel bağımlılıklar yükleniyor..."
sudo apt update && sudo apt install curl wget screen jq -y

if ! command -v docker &> /dev/null; then
  echo -e "${ORANGE}Docker bulunamadı, kurulum başlatılıyor...${RESET}"
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  rm get-docker.sh
fi

ufw allow 22
ufw allow ssh
ufw enable
ufw allow 40400
ufw allow 8080

echo "⬇️ Aztec CLI Yükleniyor.."

curl -fsSL https://install.aztec.network | bash
export PATH="$HOME/.aztec/bin:$PATH"

echo "🔄 Aztec güncel versiyon yükleniyor.."
aztec-up alpha-testnet

echo -e "\n🌐 RPC Çökmemesi için 3 tane farklı RPC kullanabilirsiniz (Eğer ücretli RPC kullanıyorsanız sadece 1.ye girip diğerlerini boş bırakabilirsiniz):"
read -p "1. Sepolia RPC: " RPC1
read -p "2. Sepolia RPC: " RPC2
read -p "3. Sepolia RPC: " RPC3

ETHEREUM_HOSTS=$(printf "%s\n%s\n%s\n" "$RPC1" "$RPC2" "$RPC3" | awk NF | paste -sd, -)

read -p "🔑 Metamask özel anahtarını girin: " RAW_KEY
if [[ "$RAW_KEY" == 0x* ]]; then
  VALIDATOR_PRIVATE_KEY="$RAW_KEY"
else
  VALIDATOR_PRIVATE_KEY="0x$RAW_KEY"
fi

read -p "👛 Metamask cüzdan adresini girin: " COINBASE
read -p "🌍 Sunucu ip adresini girin: " P2P_IP

# Beacon RPC kullanıcıdan isteğe bağlı alınır
read -p "🛰️ Beacon RPC girin (boş bırakırsanız varsayılan kullanılacak): " CUSTOM_BEACON_RPC

if [[ -z "$CUSTOM_BEACON_RPC" ]]; then
  L1_CONSENSUS_HOST_URLS="https://eth-beacon-chain-sepolia.drpc.org/rest/"
  echo "ℹ️ Varsayılan Beacon RPC kullanılacak: $L1_CONSENSUS_HOST_URLS"
else
  L1_CONSENSUS_HOST_URLS="$CUSTOM_BEACON_RPC"
  echo "✅ Beacon RPC olarak şu kullanılacak: $L1_CONSENSUS_HOST_URLS"
fi


# --------------------------
# VALIDATOR SCRIPT İNDİRME
# --------------------------

echo "📥 Validator kayıt scripti indiriliyor..."
wget -O ~/validator.sh https://raw.githubusercontent.com/DoganSoley/aztec-node-kurulum/refs/heads/main/validator.sh

if [[ -f ~/validator.sh ]]; then
  chmod +x ~/validator.sh
  echo "✅ validator.sh başarıyla indirildi ve çalıştırılabilir hale getirildi."
else
  echo -e "${RED}❌ validator.sh dosyası indirilemedi. Bağlantıyı kontrol edin.${NC}"
fi

# --------------------------
# BASE64 SCRIPT İNDİRME
# --------------------------

echo "📥 Base64 yardımcı scripti indiriliyor..."
wget -O ~/base64.sh https://raw.githubusercontent.com/DoganSoley/aztec-node-kurulum/refs/heads/main/base64.sh

if [[ -f ~/base64.sh ]]; then
  chmod +x ~/base64.sh
  echo "✅ base64.sh başarıyla indirildi ve çalıştırılabilir hale getirildi."
else
  echo -e "${RED}❌ base64.sh dosyası indirilemedi. Bağlantıyı kontrol edin.${NC}"
fi

# --------------------------
# NODE YENİDEN BAŞLATMA SCRIPTİ
# --------------------------

echo "📥 Node yeniden başlatma scripti indiriliyor..."
wget -O ~/run-node.sh https://raw.githubusercontent.com/DoganSoley/aztec-node-kurulum/refs/heads/main/run-node.sh

if [[ -f ~/run-node.sh ]]; then
  chmod +x ~/run-node.sh
  echo "✅ run-node.sh başarıyla indirildi ve çalıştırılabilir hale getirildi."
else
  echo -e "${RED}❌ run-node.sh dosyası indirilemedi. Bağlantıyı kontrol edin.${NC}"
fi




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

echo "✅ Aztec node 'aztec' isimli screen içinde başlatıldı."
echo " "
echo "🔍 Log kontrol için : screen -r aztec"
echo " "
echo "🔍 Sorularınız için : t.me/CryptolossChat telegram kanalına gelebilirsiniz.."
