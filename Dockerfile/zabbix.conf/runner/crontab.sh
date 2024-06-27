#!/bin/bash
########### VERIFICAR ALERTA DE BILLING ###########
docker exec  zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.cloudwatch.alarm.billing.count -o \$(/etc/zabbix/scripts/aws-billing-alarm.sh)" >> /home/brutforce/teste.log
########### VERIFICAR FATURA PENDENTES ###########
docker exec  zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.billing.pedent -o \$(/etc/zabbix/scripts/aws-billing-pedent-2.sh)" >> /home/brutforce/teste.log
########### VERIFICA FATURA #####################
docker exec zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.billing.count -o \$(/etc/zabbix/scripts/aws-billing-pedent.sh)"
########## VARIFICAR BUCKET S3 SEM CRYPTO ########
docker exec  zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.s3.allow.pub -o \$(/etc/zabbix/scripts/aws-check-s3-public.sh)" >> /home/brutforce/teste.log
###########VERIFICAR INSTANCIAS RESERVADAS ########
docker exec zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.ec2.ondemand.count -o \$(/etc/zabbix/scripts/aws-ec2-ondemand.sh)" >> /home/brutforce/teste.log
########## VERIFICAR QUANTIDADE DE IAM USER
docker exec zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.ec2.package.update.count -o \$(/etc/zabbix/scripts/aws-ec2-package-update-list.sh)"
##########3 TOTAL DE ISNTANCIAS RUNNING
docker exec  zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.ec2.running.count -o \$(/etc/zabbix/scripts/aws-ec2-total-instance.sh)" >> /home/brutforce/teste.log
########## VERIFICAR QUANTIDADE DE IAM USER
docker exec zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.iam.count -o \$(/etc/zabbix/scripts/aws-iam-user-count.sh)" 
######### VERIFICAR USUARIOS COM MAIS DE 60 DIAS DE INATIVIDADE
docker exec  zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.iam.day.count -o \$(/etc/zabbix/scripts/aws-iam-user-date.sh)" 
docker exec zabbix-agent /bin/bash -c "zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.sns.count -o \$(/etc/zabbix/scripts/aws-sns-count.sh)"
