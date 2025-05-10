#!/bin/bash

# Renkler
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

echo -e "${BLUE}🛡️  Aztec Validator Kayıt İşlemi Başlatılıyor${NC}"

# Kullanıcıdan bilgileri al
read -p "🌐 Sepolia RPC girin: " RPC_URL
read -p "🔐 Metamask özel anahtarınızı girin: " RAW_KEY
read -p "📬 Metamask cüzdan adresinizi girin: " VALIDATOR_ADDRESS

# Private key'e 0x ekle (yoksa)
if [[ "$RAW_KEY" == 0x* ]]; then
  PRIVATE_KEY="$RAW_KEY"
else
  PRIVATE_KEY="0x$RAW_KEY"
fi

# Sabit parametreler
STAKING_HANDLER="0xF739D03e98e23A7B65940848aBA8921fF3bAc4b2"
CHAIN_ID="11155111"

# Kayıt işlemi başlatılıyor
echo -e "\n🚀 Validatör olarak kayıt olunuyor, lütfen bekleyin...\n"

OUTPUT=$(aztec add-l1-validator \
  --l1-rpc-urls "$RPC_URL" \
  --private-key "$PRIVATE_KEY" \
  --attester "$VALIDATOR_ADDRESS" \
  --proposer-eoa "$VALIDATOR_ADDRESS" \
  --staking-asset-handler "$STAKING_HANDLER" \
  --l1-chain-id "$CHAIN_ID" 2>&1)

echo "$OUTPUT" > ~/aztec-validator-log.txt

# Günlük kayıt limiti dolmuş mu kontrol et
if echo "$OUTPUT" | grep -q "ValidatorQuotaFilledUntil"; then
  TIMESTAMP=$(echo "$OUTPUT" | grep -oP 'ValidatorQuotaFilledUntil\(\K[0-9]+')
  NOW=$(date +%s)
  SECONDS_LEFT=$(( TIMESTAMP - NOW ))

  if (( SECONDS_LEFT > 0 )); then
    HOURS=$(( SECONDS_LEFT / 3600 ))
    MINUTES=$(( (SECONDS_LEFT % 3600) / 60 ))
    echo -e "${RED}⛔ Günlük validator kayıt sınırına ulaşıldı.${NC}"
    echo -e "⏳ Lütfen yaklaşık ${YELLOW}$HOURS saat $MINUTES dakika${NC} sonra tekrar deneyin."
  else
    echo -e "${RED}⛔ Kayıt şu anda mümkün değil, ancak tekrar denenebilir.${NC}"
  fi
else
  echo -e "\n${GREEN}✅ Validatör kaydı başarılı!${NC}"
fi
