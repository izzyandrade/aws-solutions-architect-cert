#! /bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

if [ $# -eq 0 ]; then
    echo "Usage: $0 <vpc-name>"
    exit 1
fi

VPC_NAME=$1

echo -e "\nCreating VPC $VPC_NAME"
echo "Region: sa-east-1"

VPC_ID=$(aws ec2 create-vpc \
 --cidr-block 10.0.0.0/16 \
 --region sa-east-1 \
 --tag-specifications "ResourceType=vpc,Tags=[{Key=VpcName,Value=${VPC_NAME}}]" \
 --query 'Vpc.VpcId' \
 --output text)

# Enable DNS hostnames for the VPC
aws ec2 modify-vpc-attribute \
 --vpc-id $VPC_ID \
 --enable-dns-hostnames "{\"Value\":true}"

echo "$VPC_ID" > vpc-id.txt


## Create Internet Gateway

echo -e "\nCreating Internet Gateway"

INTERNET_GATEWAY_ID=$(aws ec2 create-internet-gateway \
 --region sa-east-1 \
 --tag-specifications "ResourceType=internet-gateway,Tags=[{Key=VpcName,Value=${VPC_NAME}}]" \
 --query 'InternetGateway.InternetGatewayId' \
 --output text)

echo "$INTERNET_GATEWAY_ID" > internet-gateway-id.txt

 ## Attach Internet Gateway to VPC

 echo -e "\nAttaching Internet Gateway to VPC"

 aws ec2 attach-internet-gateway \
 --vpc-id $VPC_ID \
 --internet-gateway-id $INTERNET_GATEWAY_ID

 ## Create a subnet
 echo -e "\nCreating a subnet"

 SUBNET_ID=$(aws ec2 create-subnet \
 --vpc-id $VPC_ID \
 --cidr-block 10.0.1.0/24 \
 --region sa-east-1 \
 --tag-specifications "ResourceType=subnet,Tags=[{Key=VpcName,Value=${VPC_NAME}}]" \
 --query 'Subnet.SubnetId' \
 --output text)

echo "$SUBNET_ID" > subnet-id.txt

## Enable auto-assign public IPv4 address for the subnet
echo -e "\nEnabling auto-assign public IPv4 address for the subnet"

aws ec2 modify-subnet-attribute \
 --subnet-id $SUBNET_ID \
 --map-public-ip-on-launch


## get the route table ID from the VPC
echo -e "\nGetting the route table ID"

ROUTE_TABLE_ID=$(aws ec2 describe-route-tables \
 --filters "Name=vpc-id,Values=${VPC_ID}" \
 --query 'RouteTables[0].RouteTableId' \
 --output text)

echo "$ROUTE_TABLE_ID" > route-table-id.txt

## explicitly associate the subnet with the internet gateway
echo -e "\nAssociating subnet with internet gateway"

aws ec2 associate-route-table \
 --subnet-id $SUBNET_ID \
 --route-table-id $ROUTE_TABLE_ID \
 --output text

 ## create a route from the route table to the internet gateway
echo -e "\nCreating a route from the route table to the internet gateway"

aws ec2 create-route \
 --route-table-id $ROUTE_TABLE_ID \
 --destination-cidr-block 0.0.0.0/0 \
 --gateway-id $INTERNET_GATEWAY_ID \
 --output text
