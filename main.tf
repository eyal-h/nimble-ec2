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
  #if you are running from AWS ec2 linux instance please use bellow credentials section
  #shared_credentials_file = "$HOME/.aws/credentials"
  #profile = "default"
}