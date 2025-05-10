#!/bin/bash

# 🌐 RPC ayarlarını al
echo -e "\n🌐 RPC çökmesini önlemek için 3 farklı Sepolia RPC girebilirsiniz."
echo "💡 Eğer ücretli RPC kullanıyorsanız sadece 1.ye girip diğerlerini boş bırakıp enter'a basabilirsiniz."

read -p "1. Sepolia RPC: " RPC1
read -p "2. Sepolia RPC: " RPC2
read -p "3. Sepolia RPC: " RPC3

# Boş RPC’leri filtrele
ETHEREUM_HOSTS=$(printf "%s\n%s\n%s\n" "$RPC1" "$RPC2" "$RPC3" | awk NF | paste -sd, -)

# Private key kontrolü
read -p "🔑 Metamask özel anahtarınızı girin: " RAW_KEY
if [[ "$RAW_KEY" == 0x* ]]; then
  VALIDATOR_PRIVATE_KEY="$RAW_KEY"
else
  VALIDATOR_PRIVATE_KEY="0x$RAW_KEY"
fi

# Diğer bilgiler
read -p "👛 Metamask cüzdan adresinizi girin: " COINBASE
read -p "🌍 Sunucunun IP adresini girin: " P2P_IP

# Beacon (consensus) RPC sabit
L1_CONSENSUS_HOST_URLS="https://eth-beacon-chain-sepolia.drpc.org/rest/"

# ✅ Node başlatılıyor (yeni screen AÇILMAZ!)
echo -e "\n🚀 Node yeniden başlatılıyor..\n"

aztec start --node --archiver --sequencer \
  --network alpha-testnet \
  --l1-rpc-urls "$ETHEREUM_HOSTS" \
  --l1-consensus-host-urls "$L1_CONSENSUS_HOST_URLS" \
  --sequencer.validatorPrivateKey "$VALIDATOR_PRIVATE_KEY" \
  --sequencer.coinbase "$COINBASE" \
  --p2p.p2pIp "$P2P_IP" | tee ~/aztec-log.txt
