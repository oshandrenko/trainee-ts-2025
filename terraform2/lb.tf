resource "aws_lb" "nlb" {
  name               = "blue-green-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.subnet_a.id]
  security_groups    = [aws_security_group.nlb_sg.id]

  tags = var.tags
}

resource "aws_lb_target_group" "blue_tg" {
  name     = "blue-tg"
  port     = 3306
  protocol = "TCP"
  vpc_id   = aws_vpc.main.id

  health_check {
    protocol = "TCP"
  }

  tags = var.tags
}

resource "aws_lb_target_group" "green_tg" {
  name     = "green-tg"
  port     = 3306
  protocol = "TCP"
  vpc_id   = aws_vpc.main.id

  health_check {
    protocol = "TCP"
  }

  tags = var.tags
}

resource "aws_lb_target_group_attachment" "blue_attachment" {
  for_each = { for idx, inst in module.ec2_blue : idx => inst }

  target_group_arn = aws_lb_target_group.blue_tg.arn
  target_id        = each.value.id
  port             = 3306
}

resource "aws_lb_target_group_attachment" "green_attachment" {
  for_each = { for idx, inst in module.ec2_green : idx => inst }

  target_group_arn = aws_lb_target_group.green_tg.arn
  target_id        = each.value.id
  port             = 3306
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 3306
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = var.active_color == "blue" ? aws_lb_target_group.blue_tg.arn : aws_lb_target_group.green_tg.arn
  }
}
