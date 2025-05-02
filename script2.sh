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
