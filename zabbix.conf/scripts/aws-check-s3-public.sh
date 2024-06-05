#!/bin/bash

# Consulta a lista de buckets S3 e conta quantos existem
s3_bucket_count=$(aws s3api list-buckets --query "Buckets[*].[Name]" --output json | jq length)

echo  $s3_bucket_count
