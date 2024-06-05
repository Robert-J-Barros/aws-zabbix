#!/bin/bash

# Obter a lista de todos os buckets S3
buckets=$(aws s3api list-buckets --query "Buckets[].Name" --output text)

# Inicializar contador para buckets não criptografados
non_encrypted_count=0

# Loop através de cada bucket e verificar a criptografia
for bucket in $buckets; do
  encryption=$(aws s3api get-bucket-encryption --bucket "$bucket" --query "ServerSideEncryptionConfiguration" --output text 2>/dev/null)
  
  if [ -z "$encryption" ]; then
    # Incrementar o contador se o bucket não estiver criptografado
    non_encrypted_count=$((non_encrypted_count + 1))
  fi
done

# Imprimir o número de buckets não criptografados
echo $non_encrypted_count

