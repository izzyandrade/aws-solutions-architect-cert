#! /bin/bash

VPC_ID=$(cat ./vpc-id.txt)
IGW_ID=$(cat ./internet-gateway-id.txt)
RT_ID=$(cat ./route-table-id.txt)
SUBNET_ID=$(cat ./subnet-id.txt)

## detach Internet Gateway from VPC
echo "Detaching Internet Gateway from VPC"

aws ec2 detach-internet-gateway \
 --internet-gateway-id $IGW_ID \
 --vpc-id $VPC_ID

## delete Internet Gateway
echo "Deleting Internet Gateway"
aws ec2 delete-internet-gateway \
 --internet-gateway-id $IGW_ID

## delete the subnets
echo "Deleting Subnets"
aws ec2 delete-subnet \
 --subnet-id $SUBNET_ID


## delete VPC
echo "Deleting VPC $VPC_ID"

aws ec2 delete-vpc \
 --vpc-id $VPC_ID
