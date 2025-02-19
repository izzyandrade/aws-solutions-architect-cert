## Query EC2 instances and use a JQ query to filter the results

Something like this:

```bash
aws ec2 describe-vpcs | jq '.Vpcs[].CidrBlock'
```

Should return a list of CIDR blocks for all VPCs.

> Docs for jq: https://jqlang.org/manual/
