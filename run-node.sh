#!/bin/bash

# 🌐 RPC ayarları
echo -e "\n🌐 RPC çökmesini önlemek için 3 tane farklı Sepolia RPC kullanabilirsiniz."
echo "💡 Eğer ücretli RPC kullanıyorsanız sadece 1.ye girip diğerlerini boş bırakabilirsiniz."

read -p "1. Sepolia RPC: " RPC1
read -p "2. Sepolia RPC: " RPC2
read -p "3. Sepolia RPC: " RPC3

# Boş RPC’leri filtrele
ETHEREUM_HOSTS=$(printf "%s\n%s\n%s\n" "$RPC1" "$RPC2" "$RPC3" | awk NF | paste -sd, -)

# Validator key
read -p "🔑 Metamask özel anahtarınızı girin: " RAW_KEY
if [[ "$RAW_KEY" == 0x* ]]; then
  VALIDATOR_PRIVATE_KEY="$RAW_KEY"
else
  VALIDATOR_PRIVATE_KEY="0x$RAW_KEY"
fi

# Cüzdan adresi ve IP
read -p "👛 Metamask cüzdan adresinizi girin: " COINBASE
read -p "🌍 Sunucu IP adresini girin: " P2P_IP

# Beacon RPC (isteğe bağlı)
read -p "🛰️ Beacon RPC girin (boş bırakırsanız varsayılan kullanılacak): " CUSTOM_BEACON_RPC
if [[ -z "$CUSTOM_BEACON_RPC" ]]; then
  L1_CONSENSUS_HOST_URLS="https://eth-beacon-chain-sepolia.drpc.org/rest/"
  echo "ℹ️ Varsayılan Beacon RPC kullanılacak: $L1_CONSENSUS_HOST_URLS"
else
  L1_CONSENSUS_HOST_URLS="$CUSTOM_BEACON_RPC"
  echo "✅ Beacon RPC olarak şu kullanılacak: $L1_CONSENSUS_HOST_URLS"
fi

# 🧱 Node başlatılıyor (bulunduğu yerde)
echo -e "\n🚀 Node başlatılıyor...\n"

aztec start --node --archiver --sequencer \
  --network alpha-testnet \
  --l1-rpc-urls "$ETHEREUM_HOSTS" \
  --l1-consensus-host-urls "$L1_CONSENSUS_HOST_URLS" \
  --sequencer.validatorPrivateKey "$VALIDATOR_PRIVATE_KEY" \
  --sequencer.coinbase "$COINBASE" \
  --p2p.p2pIp "$P2P_IP" | tee ~/aztec-log.txt

# 🧪 Alchemy limiti kontrolü
if grep -q "Monthly capacity limit exceeded" ~/aztec-log.txt; then
  echo -e "\n❌ RPC sağlayıcınız (örneğin Alchemy) aylık sınırı aştı!"
  echo "🔁 Yeni bir Sepolia RPC girerek node'u tekrar başlatmalısınız."
  echo "📜 Hata logu: ~/aztec-log.txt"
else
  echo -e "\n✅ Node başarıyla başlatıldı!"
fi
