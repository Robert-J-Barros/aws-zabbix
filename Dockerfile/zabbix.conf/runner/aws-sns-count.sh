#!/bin/bash
docker exec zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.sns.count -o \$(/etc/zabbix/scripts/aws-sns-count.sh)"
