resource "aws_lb" "load_balancer" {
  name               = "ada-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls.id]
  subnets            = [aws_subnet.publica_a.id, aws_subnet.publica_b.id, aws_subnet.publica_c.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name     = "ada-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ada_vpc.id
}

resource "aws_lb_target_group_attachment" "ada_ec2_a" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = aws_instance.ec2_privada_azA.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "ada_ec2_b" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = aws_instance.ec2_privada_azB.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "ada_ec2_c" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = aws_instance.ec2_privada_azC.id
  port             = 80
}

resource "aws_lb_listener" "ada_lb_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}
