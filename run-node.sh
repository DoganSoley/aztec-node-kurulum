#!/bin/bash

echo "🧹 Eski node verileri temizleniyor..."
rm -rf /root/.aztec/alpha-testnet

echo "🚀 Aztec node başlatılıyor..."

# Kullanıcıdan bilgileri al
read -p "🔗 Sepolia RPC girin: " RPC_URL
read -p "🔐 Metamask özel anahtarını girin: " PRIVATE_KEY
read -p "📬 Metamask cüzdan adresini girin: " COINBASE
read -p "🌐 Sunucu ip adresini girin: " IP_ADDR

# Node'u başlat
aztec start --node --archiver --sequencer \
  --network alpha-testnet \
  --l1-rpc-urls "$RPC_URL" \
  --l1-consensus-host-urls https://rpc.drpc.org/eth/sepolia/beacon \
  --sequencer.validatorPrivateKey "$PRIVATE_KEY" \
  --sequencer.coinbase "$COINBASE" \
  --p2p.p2pIp "$IP_ADDR"
