#!/bin/bash
########### VERIFICAR ALERTA DE BILLING ###########
docker exec  zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.cloudwatch.alarm.billing.count -o \$(/etc/zabbix/scripts/aws-billing-alarm.sh)" >> /home/brutforce/teste.log
