#!/bin/bash
aws ec2 describe-subnets
aws ec2 describe-key-pairs
read -p "type the name of the key pair you wish to use:" sshkey
aws ec2 create-security-group --group-name WireGuardServerSG --description "WireGuard Port 22,80,443,51820" --vpc-id vpc-a330bcc8
aws ec2 authorize-security-group-ingress --group-name WireGuardServerSG --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name WireGuardServerSG --protocol udp --port 51820 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name WireGuardServerSG --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name WireGuardServerSG --protocol tcp --port 443 --cidr 0.0.0.0/0
read -p "Copy the GroupID: "sg-xyz" and paste it here:" SG_NAME
aws ec2 describe-subnet
read -p "Copy the SubnetId You wand to use from list and Paste it here:" SUBNET

aws ec2 run-instances --image-id ami-00399ec92321828f5 --count 1 --instance-type t2.micro \
--key-name $sshkey --subnet-id $SUBNET --security-group-ids $SG_NAME \
--user-data file://wg_server_setup.sh


