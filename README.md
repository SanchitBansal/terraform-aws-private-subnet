# Terraform AWS Private Subnet Module

This is Terraform module to create private subnet with network acl, route table in AWS.

**This module requires Terraform v0.11.**

```hcl
module "private_subnet_db" {
  source = "github.com/SanchitBansal/terraform-private-subnet.git"

  vpc_id = "vpc-xxxxx"
  name = "db"
  environment = "test"
  availability_zones  = ["ap-south-1a", "ap-south-1b"]
  businessunit = "techteam"
  organization = "github"

  private_subnets = ["192.168.100.0/25", "192.168.100.128/25"]
}
```

The module creates subnet CIDRs provided in private_subnets var and names them in the combination of "environment", "name" and "availability zone". This is completely a generic module which can be used by anyone to create n number of subnets, keeping every subnet type in different module, like:

```hcl
module "private_subnet_db" {
  source = "github.com/SanchitBansal/terraform-private-subnet.git"
  
  vpc_id = "vpc-xxxxx"
  name = "db"
  environment = "test"
  availability_zones  = ["ap-south-1a", "ap-south-1b"]
  businessunit = "techteam"
  organization = "github"

  private_subnets = ["192.168.100.0/25", "192.168.100.128/25"]
}

module "private_subnet_app" {
  source = "github.com/SanchitBansal/terraform-private-subnet.git"
  
  vpc_id = "vpc-xxxxx"
  name = "app"
  environment = "test"
  availability_zones  = ["ap-south-1a", "ap-south-1b"]
  businessunit = "techteam"
  organization = "github"

  nat_gateway_ids = ["nat-xxx","nat-yyy"]
  nat_gateway_required = "true"

  private_subnets = ["192.168.101.0/25", "192.168.101.128/25"]
}
```

Also you can increase/ decrease availability zones as the requirement comes in future, it won't break :)

```hcl
module "private_subnet_db" {
  source = "github.com/SanchitBansal/terraform-private-subnet.git"
  
  vpc_id = "vpc-xxxxx"
  name = "db"
  environment = "test"
  availability_zones  = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  businessunit = "techteam"
  organization = "github"

  private_subnets = ["192.168.100.0/25", "192.168.100.128/25", "192.168.102.0/25"]	
}
```

**I will keep enhancing it if found any issues or any feature request from your side**
