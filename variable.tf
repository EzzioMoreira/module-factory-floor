variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-2"
}

variable "vpc_cidr_block" {
  description = "Range of IPv4 address for the VPC."
  default     = "10.10.0.0/16"
}

variable "az_count" {
  description = "The number of Availability Zones that we will deploy into"
  default     = "2"
}

variable "environment" {
  description = "Name of environment to be created"
}