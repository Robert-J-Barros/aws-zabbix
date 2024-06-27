########### VERIFICAR FATURA PENDENTES ###########
docker exec  zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.billing.pedent -o \$(/etc/zabbix/scripts/aws-billing-pedent-2.sh)" >> /home/brutforce/teste.log
