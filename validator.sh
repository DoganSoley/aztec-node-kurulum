#!/bin/bash

# Renkler
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🛡️  Aztec Validator Kayıt İşlemi Başlatılıyor${NC}"

# Bilgi al
read -p "🌐 Sepolia RPC bağlantı adresinizi girin: " RPC_URL
read -p "🔐 Metamask özel anahtarınızı girin (0x ile başlayabilir veya başlamayabilir): " RAW_KEY
read -p "📬 Metamask cüzdan adresinizi girin: " VALIDATOR_ADDRESS

# Private key formatla
if [[ "$RAW_KEY" == 0x* ]]; then
  PRIVATE_KEY="$RAW_KEY"
else
  PRIVATE_KEY="0x$RAW_KEY"
fi

# Parametreler
STAKING_HANDLER="0xF739D03e98e23A7B65940848aBA8921fF3bAc4b2"
CHAIN_ID="11155111"

# Komut çalıştırılıyor
echo -e "\n🚀 Validatör olarak kayıt olunuyor, lütfen bekleyin...\n"

OUTPUT=$(aztec add-l1-validator \
  --l1-rpc-urls "$RPC_URL" \
  --private-key "$PRIVATE_KEY" \
  --attester "$VALIDATOR_ADDRESS" \
  --proposer-eoa "$VALIDATOR_ADDRESS" \
  --staking-asset-handler "$STAKING_HANDLER" \
  --l1-chain-id "$CHAIN_ID" 2>&1)

# Log dosyasına yaz
echo "$OUTPUT" > ~/aztec-validator-log.txt

# Quota dolmuş mu?
if echo "$OUTPUT" | grep -q "ValidatorQuotaFilledUntil"; then
  TIMESTAMP=$(echo "$OUTPUT" | grep -oP 'ValidatorQuotaFilledUntil\(\K[0-9]+')

  if [[ -n "$TIMESTAMP" ]]; then
    NOW=$(date +%s)
    SECONDS_LEFT=$(( TIMESTAMP - NOW ))
    HOURS=$(( SECONDS_LEFT / 3600 ))
    MINUTES=$(( (SECONDS_LEFT % 3600) / 60 ))

    echo -e "${RED}⛔ Günlük validator kayıt sınırına ulaşıldı.${NC}"
    echo -e "⏳ Yaklaşık ${YELLOW}$HOURS saat $MINUTES dakika${NC} sonra tekrar deneyin."
  else
    echo -e "${RED}⛔ Kayıt şu anda mümkün değil, ancak tekrar denenebilir.${NC}"
    echo -e "${YELLOW}ℹ️ Zaman bilgisi alınamadı. Lütfen birkaç saat sonra tekrar deneyin.${NC}"
  fi

# RPC limiti hatası
elif echo "$OUTPUT" | grep -qi "Monthly capacity limit exceeded"; then
  echo -e "${RED}⛔ RPC sağlayıcınızın aylık kullanım limiti dolmuş.${NC}"
  echo -e "🔄 Lütfen farklı bir RPC ile tekrar deneyin."

# ✅ GERÇEK başarı kontrolü
elif echo "$OUTPUT" | grep -q "Successfully added L1 validator"; then
  echo -e "\n${GREEN}✅ Validatör kaydı başarılı!${NC}"

# ❌ Hiçbiri yoksa: bilinmeyen hata
else
  echo -e "${RED}⛔ Kayıt başarısız olmuş olabilir. Log dosyasını kontrol edin.${NC}"
  echo -e "📄 Log: ${YELLOW}~/aztec-validator-log.txt${NC}"
fi
