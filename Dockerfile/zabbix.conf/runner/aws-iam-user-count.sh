#!/bin/bash
########## VERIFICAR QUANTIDADE DE IAM USER
docker exec zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.iam.count -o \$(/etc/zabbix/scripts/aws-iam-user-count.sh)" 
