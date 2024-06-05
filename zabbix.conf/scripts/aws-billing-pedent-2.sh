#!/bin/bash

# Verifica o saldo atual da conta AWS
billing_info=$(aws ce get-cost-and-usage --time-period Start=$(date +%Y-%m-01),End=$(date -d "$(date +%Y-%m-01) +1 month -1 day" +%Y-%m-%d) --granularity MONTHLY --metrics "BlendedCost" --output json)

# Extrai o valor total de custos do JSON
total_cost=$(echo $billing_info | jq -r '.ResultsByTime[0].Total.BlendedCost.Amount')

if (( $(echo "$total_cost > 0" | bc -l) )); then
  valide=1
else
  valide=0
fi

echo $valide

