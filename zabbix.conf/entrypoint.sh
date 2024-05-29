#!/bin/bash

/usr/sbin/zabbix_agentd -f
tail -f /dev/null
