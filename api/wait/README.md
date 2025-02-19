## Create an EC2 instance

## Run EC2 Instance

```bash
aws ec2 run-instances \
--image-id ami-0dfd25aa3bea35697 \
--instance-type t2.micro \
--query 'Instances[0].InstanceId' \
--output text
```

> i-0d9179e048221b629

## Watch and wait for the instance to be running

```bash
aws ec2 wait instance-status-ok \
--instance-ids i-0d9179e048221b629
```

> the command will keep execution paused until the instance is running with status OK

## Clean up

```bash
aws ec2 terminate-instances \
--instance-ids i-0d9179e048221b629
```
