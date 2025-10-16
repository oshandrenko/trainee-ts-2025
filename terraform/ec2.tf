module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.1.1"

  count = 2

  name                   = "DB-Instance-${count.index + 1}"
  ami                    = data.aws_ami.ami_id.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  associate_public_ip_address = true
  key_name               = var.key_name

  tags = merge(var.tags, { Name = "DB-Instance-${count.index + 1}" })
}
