To run this example, you need to have the AWS CLI installed and configured.

The script `create-vpc.sh` will create a VPC, subnets, internet gateway, route table, and associate the subnets to the route table.

To run it, you can use the following command:

```bash
./create-vpc.sh <vpc-name>
```

This command will output the VPC ID, Subnet IDs, and Route Table ID to `.txt` files which will be used to delete the resources created.

Delete all the resources created by running `delete-vpc.sh` script with the following command:

```bash
./delete-vpc.sh
```
