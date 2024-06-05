#!/bin/bash
billing_alarms=$(aws cloudwatch describe-alarms --query 'MetricAlarms[?Namespace==`AWS/Billing`]' --output json)
billing_alarm_count=$(echo $billing_alarms | jq '. | length')

if [ "$billing_alarm_count" -gt 0 ]; then
  echo  $billing_alarm_count 
else
  echo 0 
fi

