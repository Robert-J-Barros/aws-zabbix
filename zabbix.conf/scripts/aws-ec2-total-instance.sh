#!/bin/bash

# Define a região específica para a pesquisa
region="sa-east-1"

# Obtém a lista de todas as instâncias EC2 e seus estados na região sa-east-1
instances_info=$(aws ec2 describe-instances --region $region --query "Reservations[*].Instances[*].State.Name" --output json)

# Conta o número de instâncias em estado "running" na região sa-east-1
running_instances_count=$(echo $instances_info | jq '[.[][] | select(. == "running")] | length')

# Retorna o número de instâncias em execução na região sa-east-1
echo "Número de instâncias em execução na região $region: $running_instances_count"

