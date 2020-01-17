#!/bin/sh
curl -sSl https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm -o amazon-ssm-agent.rpm
rpm2cpio amazon-ssm-agent.rpm > amazon-ssm-agent.cpio
cpio -idmv < amazon-ssm-agent.cpio
