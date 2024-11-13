terraform {
  required_version = ">=1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.75.0"
    }
  }

  # backend "s3" {
  #   bucket = aws_s3_bucket.ada_s3_bucket.bucket
  #   key    = "state/terraform.tfstate"
  #   region = "us-east-1"
  # }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      projeto = "ada"
      dono    = "igor"
    }
  }
}
