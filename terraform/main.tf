# main.tf
provider "aws" {
  region = "eu-west-1"
}

data "aws_caller_identity" "current" {}
# Configure the backend
# This is where the Terraform state will be stored
# In the case of using Terraform Cloud
terraform {
  backend "remote" {
    organization = "Test-Organisation"  #Change this before code share
    workspaces {
      name = "devops-http-poc"  #Change this before code share
    }
  }
}