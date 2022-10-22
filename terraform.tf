terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=4.22.0"
    }
  }

  backend "s3" {
    encrypt        = true
    bucket         = "callofthevoid-terraform-statefiles"
    dynamodb_table = "terraform-statefile-locks"
    region         = "eu-central-1"
    key            = "cloudformation.tfstate"
  }

  required_version = ">=1.2.4"
}

provider "aws" {
  alias               = "frankfurt"
  region              = "eu-central-1"
  allowed_account_ids = ["470214011505"] # callofthevoid
}
