#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo su --
amazon-linux-extras install docker
service docker start
usermod -a -G docker ec2-user
chkconfig docker on
yum install -y git
curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
git clone https://github.com/LincolnRoy/ELK-Stack.git
cd /ELK-Stack/
docker-compose -f docker-compose.yaml up -d
