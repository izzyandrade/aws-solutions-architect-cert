# Setup

Create the infrastructure in CloudFormation with the following command:

```bash
aws cloudformation create-stack --stack-name nacl-example --template-body file://nacl-example.yaml --capabilities CAPABILITY_NAMED_IAM
```

# Test

The following command will give you the public IP address of the (most recently created) EC2 instance:

```bash
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[LaunchTime,PublicIpAddress]' --output text | sort -r | head -n 1 | awk '{print $2}'
```

Open the browser and navigate to the public IP address outputted by the command above. You should see the default Apache page.

Now, let's create a NACL and add a rule to it to block HTTP traffic from our own IP address.

To do that, get the VPC ID from the CloudFormation stack output:

```bash
aws cloudformation describe-stacks --stack-name nacl-example --query 'Stacks[0].Outputs[?OutputKey==`VpcId`].OutputValue' --output text
```

Use that ID to create a NACL like this, and note the NACL ID:

```bash
aws ec2 create-network-acl --vpc-id <vpc-id> --tag-specifications 'ResourceType=network-acl,Tags=[{Key=Name,Value=nacl-example}]'
```

Add a rule to the NACL to block HTTP traffic from our own IP address (Grab your IP address from the internet). Note the NACL ID from the previous command:

```bash
aws ec2 create-network-acl-entry \
--network-acl-id acl-0b627c62c29c0c725 \
--ingress \
--rule-number 100 \
--protocol -1 \
--rule-action deny \
--cidr-block 177.220.183.213/32 \
--port-range From=0,To=65535
```

Since this is not the default NACL, we need to associate it with the subnet and also add inbound and outbound rules to allow all traffic. This can be done through the AWS Console.

With that done, try to access the public IP address of the EC2 instance again. You should be blocked.

# Cleanup

Delete the infrastructure in CloudFormation with the following command:

```bash
aws cloudformation delete-stack --stack-name nacl-example
```
