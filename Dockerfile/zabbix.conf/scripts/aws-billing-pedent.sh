#!/bin/bash

# Verifica o saldo atual da conta AWS
billing_info=$(aws ce get-cost-and-usage --time-period Start=$(date +%Y-%m-01),End=$(date -d "$(date +%Y-%m-01) +1 month -1 day" +%Y-%m-%d) --granularity MONTHLY --metrics "BlendedCost" --output json)

# Extrai o valor total de custos do JSON
total_cost=$(echo $billing_info | jq -r '.ResultsByTime[0].Total.BlendedCost.Amount')

echo  $total_cost 

# Verifica se há valores devidos (isso é mais um exemplo, pois a AWS CLI não fornece um comando direto para verificar faturas pendentes)
# Aqui estamos assumindo que qualquer custo é considerado como uma "fatura pendente" para simplificação
#if (( $(echo "$total_cost > 0" | bc -l) )); then
#  echo "Há faturas pendentes na conta AWS."
#else
#  echo "Não há faturas pendentes na conta AWS."
#fi

