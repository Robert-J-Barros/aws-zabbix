#!/bin/bash
sns_topic_count=$(aws sns list-topics --query 'Topics[*]' --output json | jq '. | length')
echo $sns_topic_count

