#!/bin/bash

# Especifique a região desejada
REGION="sa-east-1"

# Obter a contagem de instâncias em execução na região especificada
running_instances_count=$(aws ec2 describe-instances --filters Name=instance-state-name,Values=running --region $REGION --query 'Reservations[*].Instances[*].InstanceId' --output text | wc -w)

echo $running_instances_count

