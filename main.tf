provider "aws" {
    region = "us-east-1"
}
resource "aws_s3_bucket" "my_buckets" {
        bucket = lookup(var.bucket_name,  var.environment, "test")
}
terraform {
  backend "s3" {
    bucket       = "fita-550"
    key          = "statefile/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    
  }
}
variable "bucket_name" {
  type = map(string)
  default = {
    dev  = "my-dev-bucket"
    prod = "my-prod-bucket"
  }
}
variable "environment" {
  type = string
  default = "dev"
}
        
    
