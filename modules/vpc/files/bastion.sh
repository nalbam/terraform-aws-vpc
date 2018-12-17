#!/usr/bin/env bash

# Log everything we do.
set -x
exec > /var/log/user-data.log 2>&1

runuser -l ec2-user -c "ssh-keygen -q -f ~/.ssh/id_rsa -N ''"
runuser -l ec2-user -c "git clone https://github.com/opsnow/kops-cui"
runuser -l ec2-user -c "bash /home/ec2-user/kops-cui/tools.sh"
