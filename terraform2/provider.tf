provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket       = "mytestbucket.org.ua"
    key          = "blue-green.terraform.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
  }
}