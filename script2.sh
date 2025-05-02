# 5. Aztec testnet yapılandırması
aztec-up alpha-testnet

# 6. Gerekli portların açılması
ufw allow 22
ufw allow ssh
ufw allow 40400
ufw allow 8080
echo "y" | ufw enable

# 7. Kullanıcıdan veri alma
read -p "🔗 Sepolia RPC girin: " RPC_URL
read -p "🔑 Metamask özel anahtarını girin: " PRIVATE_KEY
read -p "📬 Metamask cüzdan adresini girin: " COINBASE
read -p "🌐 Sunucu ip adresini girin: " IP_ADDR

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

# 10. Bilgilendirme
echo "✅ Aztec node 'aztec' isimli screen içinde başlatıldı."
echo " "
echo "🔍 Log kontrol için : screen -r aztec"
echo " "
echo "🔍 Sorularınız için : t.me/CryptolossChat telegram kanalına gelebilirsiniz.."
