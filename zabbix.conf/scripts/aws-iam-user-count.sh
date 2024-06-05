#!/bin/bash

# Consulta a lista de usuários IAM e conta quantos existem
iam_user_count=$(aws iam list-users --output json | jq '.Users | length')

echo $iam_user_count
