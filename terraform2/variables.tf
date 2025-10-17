variable "region" {
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_a_cidr" {
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
}

variable "instance_count_per_group" {
  type        = number
  default     = 1
  description = "Instance count"
}

variable "tags" {
  type        = map(string)
  default     = {
    Name = "Blue-Green-Project"
  }
}

variable "key_name" {
  type    = string
  default = "test"
}

variable "active_color" {
  type        = string
  default     = "blue"
  description = "'blue' or 'green'"
}

data "aws_ami" "ami_id" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["*ubuntu-noble-*-amd64-server-*"]
  }
}
