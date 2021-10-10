### This Terraform deploy:

* Create a VPC
* Create 2 private subnets
* Create 2 public subnets
* Create a internet gateway
* Route tables
* Cluster ECS

### Requisites for running this project:
- Git
- Docker
- Make

## Usage
##### Credential for AWS
Create `.env` file to AWS credentials with access key and secret key.
```shell
# AWS environment
AWS_ACCESS_KEY_ID=your-access-key-here
AWS_SECRET_ACCESS_KEY=your-secret-key-here
```
#### Create `terrafile.tf` file with content and set your configurations. If you prefer, change the variables name.
```terraform
provider "aws" {
  region  = "us-east-2"
  version = "~> 3.0"
}

terraform {
  backend "s3" {
    bucket = "metal.corp-devops-test"
    key    = "infra/factoryfloor-terraform-.tfstate"
    region = "us-east-2"
  }
}

module "dev_cluster" {
  source         = "git@github.com:EzzioMoreira/module-factory-floor.git?ref=output"
  environment    = "development"
  vpc_cidr_block = "10.2.0.0/16"
}

output "ecs_cluster_name" {
  value = module.dev_cluster.ecs_cluster_name
}

output "vpc_id" {
  value = module.dev_cluster.vpc_id
}

output "subnet_private" {
  value = module.dev_cluster.subnet_private
}
```

## Terraform inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_region | The AWS region to create things in. | string | `"us-east-2"` | yes |
| az\_count | The number of Availability Zones that we will deploy into | string | `"2"` | no |
| environment | Name of environment to be created | string | n/a | yes |
| vpc\_cidr\_block | Range of IPv4 address for the VPC. | string | `"10.10.0.0/16"` | no |
| default\_tags | Default tags name. | map | `"Key: value"` | yes |

## Outputs

| Name | Description |
|------|-------------|
| ecs_cluster_name | ECS cluster name. |
| aws\_vpc\_id | The ID of AWS VPC created for the ECS cluster. ||
