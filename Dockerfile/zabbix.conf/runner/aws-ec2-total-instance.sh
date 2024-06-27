#!/bin/bash
##########3 TOTAL DE ISNTANCIAS RUNNING
docker exec  zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.ec2.running.count -o \$(/etc/zabbix/scripts/aws-ec2-total-instance.sh)" >> /home/brutforce/teste.log
