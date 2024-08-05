# Invoice-Westminster-Terraform

Invoice-Westminster-Terraform

Prerequisites:

Ensure AWS CLI is installed. Use the following command to configure:

To install AWS CLI, refer to:

[https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

Also, ensure Docker CLI is installed.

```
aws configure --profile invoice-cg
```

Make changes in the `terraform.tfvars` file to modify the profile name, region, instance type, bucket name, tags, and other parameters.

## Services Included:

1. Bedrock
2. CloudWatch
3. EC2
4. ECR
5. ECS
6. IAM
7. RDS
8. S3
9. SNS
10. SQS
11. VPC
12. Push Docker Image to ECR
13. S3 as Remote Backend

To install Terraform, follow the documentation:

[https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Setting Up S3 Remote Backend and DynamoDB for State Lock

```bash
cd remote_backend
```

```bash
terraform init
```

```bash
terraform validate
```

```bash
terraform plan
```

```bash
terraform apply
```

Review the planned resources and enter: `yes`

To destroy:

```bash
terraform destroy
```

## Creating Infrastructure

Navigate back to the root directory.

Adjust the Docker context, Dockerfile name in `terraform.tfvars`, and other relevant details.

```bash
terraform init
```

```bash
terraform validate
```

```bash
terraform plan
```

```bash
terraform apply
```

Review the planned resources and enter: `yes`

To destroy:

```bash
terraform destroy
```
