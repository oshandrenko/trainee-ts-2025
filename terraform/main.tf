provider "aws" {
  region = "eu-central-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

terraform {
  backend "s3" {
    bucket = "mytestbucket.org.ua"
    key    = "master-slave.terraform.tfstate"
    region = "eu-central-1"
    encrypt = true
    use_lockfile = true
  }
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags       = var.tags
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr
  availability_zone = "${var.region}a"
  tags              = var.tags
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = var.tags
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = var.tags
}

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "Security group for DB replication instances"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["194.28.6.54/32"]
}

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_instance" "db_instance" {
  count         = 2
  ami           = data.aws_ami.ami_id.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.main.id
  security_groups = [aws_security_group.db_sg.id]
  associate_public_ip_address = true
  key_name      = var.key_name

  tags = merge(var.tags, { Name = "DB-Instance-${count.index + 1}" })
}


resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tmpl", {
    master_ip    = aws_instance.db_instance[0].public_ip
    slave_ip     = aws_instance.db_instance[1].public_ip
    master_internal_ip = aws_instance.db_instance[0].private_ip
    slave_internal_ip = aws_instance.db_instance[1].private_ip
    ssh_key_path = "~/Desktop/test.pem"
  })
  filename = "${path.module}/../ansible+sql/inventory/hosts.yml"
}
