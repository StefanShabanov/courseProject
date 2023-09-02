# Define the required provider for AWS with the specified version
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.14.0"
    }
  }
}

# Configure the AWS provider with the desired region
provider "aws" {
  region = "eu-central-1"
}
