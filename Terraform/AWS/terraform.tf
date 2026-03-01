terraform {
  backend "local" {
    path = "./myterraform.tfstate"
  }

  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.66"
    }
  }
}

# terraform {  
#   backend "s3" {
#     bucket = "bucketname"
#     key    = "state_dir/terraform.tfstate"
#     region = "us-east-1"
#   }
# }
