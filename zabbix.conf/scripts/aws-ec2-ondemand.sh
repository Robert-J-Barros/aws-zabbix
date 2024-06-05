#!/bin/bash
reserved_instance_count=$(aws ec2 describe-reserved-instances --query 'ReservedInstances[*]' --output json | jq '. | length')

echo  $reserved_instance_count

