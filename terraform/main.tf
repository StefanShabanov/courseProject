terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}


# Search in Google "AWS Provider terraform" and open the first link, then click on Use provider and copy the text. Then on line 11 put region="your region"