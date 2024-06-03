#!/bin/bash

# Contar o número de instâncias spot em execução
spot=$(aws ec2 describe-instances --region sa-east-1 --query 'Reservations[*].Instances[*].InstanceLifecycle' --filters Name=instance-state-name,Values=running | grep -v '\[' | grep -v '\]' | wc -l)

# Contar o número de instâncias on-demand em execução
instancias=$(aws ec2 describe-instances --region us-east-1 --query 'Reservations[*].Instances[*].InstanceId' --filters Name=instance-state-name,Values=running | grep -c '^i-')

# Calcular o número de instâncias on-demand subtraindo o número de instâncias spot do total de instâncias
ondemand=$((instancias - spot))

# Imprimir o número de instâncias on-demand
echo $ondemand

