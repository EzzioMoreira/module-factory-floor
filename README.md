# This Terraform deploy:

* Create a VPC
* Create 2 private subnets
* Create 2 public subnets
* Create a internet gateway
* Route tables
* Cluster ECS

### Requisites for running this project:
- Docker
- Make

### How to use
#### Credential for AWS
Create `.env` file to AWS credentials with access key and secret key.
```shell
# AWS environment
AWS_ACCESS_KEY_ID=your-access-key-here
AWS_SECRET_ACCESS_KEY=your-secret-key-here
```
### Create `terrafile.tf` file with content and set your configurations. If you prefer, change the variables name.
```terraform
provider "aws" {
  region  = "us-east-2"
  version = "= 3.0"
}
terraform {
  backend "s3" {
    bucket = "your-bucket-here"
    key    = "key-terraform-.tfstate"
    region = "us-east-2"
  }
}

module "dev_cluster" {
  source         = "git@github.com:EzzioMoreira/module-factory-floor.git?ref=v1.1"
  environment    = "development"
  vpc_cidr_block = "10.10.0.0/16"
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

output "subnet_public" {
  value = module.dev_cluster.subnet_public
}
```

### Terraform inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_region | The AWS region to create things in. | string | `"us-east-2"` | yes |
| az\_count | The number of Availability Zones that we will deploy into | string | `"2"` | no |
| environment | Name of environment to be created | string | n/a | yes |
| vpc\_cidr\_block | Range of IPv4 address for the VPC. | string | `"10.10.0.0/16"` | no |

### Terraform Outputs

| Name | Description |
|------|-------------|
| ecs_cluster_name | ECS cluster name. |
| aws\_vpc\_id | The ID of AWS VPC created for the ECS cluster. |
| subnet\_private | Print the cidr block subnet private. |
| subnet\_public | Print the cidr block subnet public. ||

### Run the following commands to deploy:
```make
make help:          ## Run make help.
terraform-init:     ## Run terraform init to download all necessary plugins
terraform-plan:     ## Exec a terraform plan and puts it on a file called plano
terraform-apply:    ## Uses plano to apply the changes on AWS.
terraform-destroy:  ## Destroy all resources created by the terraform file in this repo.
```