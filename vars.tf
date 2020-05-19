/**
 * variables that will be used while creating infra
 */

variable "profile" {
  description = "profile name to get valid credentials of account"
}

variable "aws_region" {
  description = "EC2 Region for the VPC"
  default     = "ap-south-1"
}

variable "name" {
  description = "the name of your subnet"
}

variable "environment" {
  description = "the name of your environment"
}

variable "businessunit" {
  description = "the name of your business unit to create"
}

variable "organization" {
  description = "the name of your organization to be used as tag"
}

variable "private_subnets" {
  description = "List of CIDRs to be created for particular subnet in different availability zones"
  type        = "list"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = "list"
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "nat_gateway_required" {
  description = "Variable to enable disable nat gateway for subnet created"
  default = "false"
}

variable "nat_gateway_ids" {
  description = "list of nat gateway ids"
  type = "list"
  default = []
}

variable "vpc_id" {
  description = "vpc id in which subnet to create"
}

variable "private_network_acl_egress" {
  description = "Egress network ACL rules"
  type        = "list"

  default = [
    {
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
    },
  ]
}

variable "private_network_acl_ingress" {
  description = "Egress network ACL rules"
  type        = "list"

  default = [
    {
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
    },
  ]
}
