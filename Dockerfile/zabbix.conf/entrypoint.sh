#!/bin/bash
export AWS_PAGER=""
service cron start
/usr/sbin/zabbix_agentd -f
tail -f /dev/null
