#!/bin/bash
######### VERIFICAR USUARIOS COM MAIS DE 60 DIAS DE INATIVIDADE
docker exec  zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.iam.day.count -o \$(/etc/zabbix/scripts/aws-iam-user-date.sh)" 
