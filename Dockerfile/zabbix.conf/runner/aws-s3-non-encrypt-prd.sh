###########S3 Sem Encriptar###
*/5 * * * * zabbix_sender -z zabbix-server -s "zabbix-agent" -k s3.prd.without.encrypt -o $(/etc/zabbix/scripts/aws-s3-encrypt-prd.sh) >> /var/log/crontab.log

###########Bucket S3 Sem#####
*/5 * * * * zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.s3.without.tag -o $(/etc/zabbix/scripts/aws-s3-without-tag-prd.sh) >> /var/log/crontab.log
########## VARIFICAR BUCKET S3 SEM CRYPTO ########
*/5 * * * * zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.s3.allow.pub -o $(/etc/zabbix/scripts/aws-check-s3-public.sh) >> /var/log/crontab.log

###########VERIFICAR SNS #####
*/5 * * * * zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.sns.count -o $(/etc/zabbix/scripts/aws-sns-count.sh) >> /var/log/crontab.log

###########VERIFICAR INSTANCIAS RESERVADAS ########
*/5 * * * * zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.ec2.ondemand.count -o $(/etc/zabbix/scripts/aws-ec2-ondemand.sh) >> /var/log/crontab.log
##########3 TOTAL DE ISNTANCIAS RUNNING
*/5 * * * * zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.ec2.running.count -o $(/etc/zabbix/scripts/aws-ec2-total-instance.sh) >> /var/log/crontab.log

########### VERIFICAR ALERTA DE BILLING ###########
*/5 * * * * zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.cloudwatch.alarm.billing.count -o $(/etc/zabbix/scripts/aws-billing-alarm.sh) >> /var/log/crontab.log
########### VERIFICAR FATURA PENDENTES ###########
*/5 * * * * zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.billing.pedent -o $(/etc/zabbix/scripts/aws-billing-pedent-2.sh) >> /var/log/crontab.log
########### VERIFICAR GASTO ATUAL DA CONTA ########
*/5 * * * * zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.billing.count -o $(/etc/zabbix/scripts/aws-billing-pedent.sh) >> /var/log/crontab.log
########## VERIFICAR QUANTIDADE DE IAM USER
*/5 * * * * zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.iam.count -o $(/etc/zabbix/scripts/aws-iam-user-count.sh) >> /var/log/crontab.log
######### VERIFICAR USUARIOS COM MAIS DE 60 DIAS DE INATIVIDADE
*/5 * * * * zabbix_sender -z zabbix-server -s "zabbix-agent" -k aws.prd.iam.day.count -o $(/etc/zabbix/scripts/aws-iam-user-date.sh) >> /var/log/crontab.log
