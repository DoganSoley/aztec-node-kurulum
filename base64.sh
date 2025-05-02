#!/bin/bash

# 1. Proven block numarasını al
BLOCK_NUM=$(curl -s -X POST -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"2.0","method":"node_getL2Tips","params":[],"id":67}' \
  http://localhost:8080 | jq -r ".result.proven.number")

echo "🔢 Son blok numarası: $BLOCK_NUM"

# 2. Aynı blok numarasını kullanarak base64 proof al
PROOF=$(curl -s -X POST -H 'Content-Type: application/json' \
  -d "{\"jsonrpc\":\"2.0\",\"method\":\"node_getArchiveSiblingPath\",\"params\":[\"$BLOCK_NUM\",\"$BLOCK_NUM\"],\"id\":67}" \
  http://localhost:8080 | jq -r ".result")

echo -e "\n📦 Base64 Proof:\n$PROOF"
