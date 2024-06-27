#!/bin/bash
########## VARIFICAR BUCKET S3 SEM CRYPTO ########
docker exec  zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.s3.allow.pub -o \$(/etc/zabbix/scripts/aws-check-s3-public.sh)" >> /home/brutforce/teste.log
