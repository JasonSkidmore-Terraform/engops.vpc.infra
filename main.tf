terraform {
  cloud {
    organization = "EngOps-SRE"

    workspaces {
      tags = ["project-engops-vpc"]
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {}

locals {


  tenant      = var.tenant
  environment = var.environment
  project     = var.project

  vpc_cidr     = var.vpc_cidr
  vpc_name     = join("-", [var.tenant, var.environment, var.project, "vpc"])

}

module "vpc-engops-sre" {
  source  = "app.terraform.io/EngOps-SRE/vpc-engops-sre/aws"
  version = "0.0.11"

  name = local.vpc_name
  cidr = local.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  public_subnets  = [for k, v in data.aws_availability_zones.available.names : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnets = [for k, v in data.aws_availability_zones.available.names : cidrsubnet(local.vpc_cidr, 8, k + 10)]

  enable_ipv6 = var.enable_ipv6

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

  public_subnet_tags = {
    Name = "overridden-name-public"
  }

  tags = {
    Owner       = var.tenant
    Environment = var.environment
  }

  vpc_tags = {
    Name = local.vpc_name
  }
}
