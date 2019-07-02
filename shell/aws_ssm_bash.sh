#!/bin/sh

#Describe EC2 instances to query out instance ID and Name
AWS_DEFAULT_PROFILE=production aws ec2 describe-instances \
    --output table --query "Reservations[*].Instances[*].{ Name: Tags[?Key == 'Name'].Value | [0], ID: InstanceId}"

#Using the output from above, you can connect to certain EC2 instance
AWS_DEFAULT_PROFILE=production aws ssm start-session --target xx