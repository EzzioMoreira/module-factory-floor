### This Module Terraform deploy:

* Create a VPC
* Create 2 subnets [Public, Private]
* Create a internet gateway
* Route tables

## Usage
##### Credential for AWS
Create .env file to AWS credentials with access key and secret key.
```shell
# AWS environment
AWS_ACCESS_KEY_ID =
AWS_SECRET_ACCESS_KEY =
```
#### Create terrafile.tf file with content and set your configurations:
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
  source        = "git@github.com:EzzioMoreira/module-factory-floor.git?ref=v1.0"
  environment   = "development"
  default_tags  = {
    Name        : "myapp",
    Team        : "IAC",
    Application : "Rapadura",
    Environment : "development",
    Terraform   : "Yes",
    Owner       : "Metal.Corp"
  }
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
