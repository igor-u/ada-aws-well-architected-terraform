resource "aws_instance" "ec2_privada_azA" {
  ami             = "ami-063d43db0594b521b"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.privada_a.id
  security_groups = [aws_security_group.allow_tls.id]

  tags = {
    Name = "ec2_privada_azA"
  }
}

resource "aws_instance" "ec2_privada_azB" {
  ami             = "ami-063d43db0594b521b"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.privada_b.id
  security_groups = [aws_security_group.allow_tls.id]

  tags = {
    Name = "ec2_privada_azB"
  }
}

resource "aws_instance" "ec2_privada_azC" {
  ami             = "ami-063d43db0594b521b"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.privada_c.id
  security_groups = [aws_security_group.allow_tls.id]

  tags = {
    Name = "ec2_privada_azC"
  }
}
