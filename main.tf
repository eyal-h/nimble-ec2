terraform {
  backend "remote" {
    organization = "nimble-company-assignment"

    workspaces {
      name = "nimble-ec2-workspace"
    }
  }
}

provider "aws" {
  region = var.aws_region
}