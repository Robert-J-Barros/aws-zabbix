#!/bin/bash
###########VERIFICAR INSTANCIAS RESERVADAS ########
docker exec zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.ec2.ondemand.count -o \$(/etc/zabbix/scripts/aws-ec2-ondemand.sh)" >> /home/brutforce/teste.log
