#!/bin/bash
docker exec zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.billing.count -o \$(/etc/zabbix/scripts/aws-billing-pedent.sh)"

