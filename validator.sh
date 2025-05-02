#!/bin/bash

echo "🛡️  Aztec Validator Kayıt"

# Kullanıcıdan bilgileri al
read -p "🔗 Sepolia RPC girin: " RPC_URL
read -p "🔐 Metamask özel anahtarını girin: " PRIVATE_KEY
read -p "📬 Metamask cüzdan adresini girin: " VALIDATOR_ADDRESS

# Sabit parametreler
STAKING_HANDLER="0xF739D03e98e23A7B65940848aBA8921fF3bAc4b2"
CHAIN_ID="11155111"

# Komutu çalıştır ve çıktıyı değişkende tut
echo -e "\n🚀 Validator olarak kaydediliyor..."
OUTPUT=$(aztec add-l1-validator \
  --l1-rpc-urls "$RPC_URL" \
  --private-key "$PRIVATE_KEY" \
  --attester "$VALIDATOR_ADDRESS" \
  --proposer-eoa "$VALIDATOR_ADDRESS" \
  --staking-asset-handler "$STAKING_HANDLER" \
  --l1-chain-id "$CHAIN_ID" 2>&1)

# Quota hatası kontrolü
if echo "$OUTPUT" | grep -q "ValidatorQuotaFilledUntil"; then
  echo -e "\n❌ Günlük validator kayıt kotası dolmuş olabilir, yarın tekrar dene."
elif echo "$OUTPUT" | grep -q "insufficient funds"; then
  echo -e "\n❌ Hesabında yeterli Sepolia ETH yok. Bu işlem için yaklaşık 2.3 Sepolia ETH gerekiyor."
elif echo "$OUTPUT" | grep -q "Successfully added"; then
  echo -e "\n✅ Validator başarıyla kaydedildi."
else
  echo -e "\n⚠️ Beklenmeyen bir hata oluştu:\n$OUTPUT"
fi
