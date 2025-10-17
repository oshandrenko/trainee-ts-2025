module "ec2_blue" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.1.1"

  count = var.instance_count_per_group

  name                        = "Blue-Instance-${count.index + 1}"
  ami                         = data.aws_ami.ami_id.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet_a.id
  vpc_security_group_ids      = [aws_security_group.db_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  tags = merge(var.tags, { Name = "Blue-Instance-${count.index + 1}", Color = "blue" })
}

module "ec2_green" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.1.1"

  count = var.instance_count_per_group

  name                        = "Green-Instance-${count.index + 1}"
  ami                         = data.aws_ami.ami_id.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet_a.id
  vpc_security_group_ids      = [aws_security_group.db_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  tags = merge(var.tags, { Name = "Green-Instance-${count.index + 1}", Color = "green" })
}
