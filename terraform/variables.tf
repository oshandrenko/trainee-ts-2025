
variable "access_key" {}
variable "secret_key" {}

variable "region" {
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
}

variable "disk_size" {
  description = "Размер EBS-диска в GiB"
  type        = number
  default     = 10
}

variable "tags" {
  type        = map(string)
  default     = {
    Name = "DB-Replication-Project"
  }
}

variable "key_name" {
  type = string
  default = "test"
}

data "aws_ami" "ami_id" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["*ubuntu-noble-*-amd64-server-*"]
  }
}
