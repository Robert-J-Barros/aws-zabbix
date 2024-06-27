#!/bin/bash

# Comando SSH para se conectar ao servidor remoto e obter a contagem de pacotes atualizáveis
result=$(ssh -i /home/brutforce/aws-zabbix/zabbix.conf/keys/airflow-prod.pem ubuntu@54.232.75.169 \
    'sudo apt update > /dev/null && sudo apt list --upgradable | wc -l')

# Imprimir o resultado localmente
echo "$result"

