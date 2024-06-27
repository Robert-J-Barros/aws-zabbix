#!/bin/bash
########## VERIFICAR QUANTIDADE DE IAM USER
docker exec zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.ec2.package.update.count -o \$(/etc/zabbix/scripts/aws-ec2-package-update-list.sh)"
