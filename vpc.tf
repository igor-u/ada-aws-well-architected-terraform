resource "aws_vpc" "ada_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terraformada"
    vpc  = "ada"
  }
}

resource "aws_subnet" "publica_a" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "publica-a"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_subnet" "publica_b" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "publica-b"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_subnet" "publica_c" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "publica-c"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_internet_gateway" "gw_ada" {
  vpc_id = aws_vpc.ada_vpc.id

  tags = {
    Name = "gatewayada"
  }
}

resource "aws_subnet" "privada_a" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "privadaapp-a"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_subnet" "privada_b" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "privadaapp-b"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_subnet" "privada_c" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "privadaapp-c"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_subnet" "dados_a" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.8.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "dados-a"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_subnet" "dados_b" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.9.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "dados-b"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_subnet" "dados_c" {
  vpc_id            = aws_vpc.ada_vpc.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "dados-c"
  }
  depends_on = [aws_vpc.ada_vpc]
}

resource "aws_eip" "nat_eip_a" {

}

resource "aws_eip" "nat_eip_b" {

}

resource "aws_eip" "nat_eip_c" {

}

resource "aws_nat_gateway" "nat_gateway_a" {
  allocation_id = aws_eip.nat_eip_a.id
  subnet_id     = aws_subnet.publica_a.id

  tags = {
    Name = "NAT-A"
  }

  depends_on = [aws_internet_gateway.gw_ada]
}

resource "aws_nat_gateway" "nat_gateway_b" {
  allocation_id = aws_eip.nat_eip_b.id
  subnet_id     = aws_subnet.publica_b.id

  tags = {
    Name = "NAT-B"
  }

  depends_on = [aws_internet_gateway.gw_ada]
}

resource "aws_nat_gateway" "nat_gateway_c" {
  allocation_id = aws_eip.nat_eip_c.id
  subnet_id     = aws_subnet.publica_c.id

  tags = {
    Name = "NAT-C"
  }

  depends_on = [aws_internet_gateway.gw_ada]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.ada_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_ada.id
  }
}

resource "aws_route_table_association" "publica-a" {
  subnet_id      = aws_subnet.publica_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "publica-b" {
  subnet_id      = aws_subnet.publica_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "publica-c" {
  subnet_id      = aws_subnet.publica_c.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "banco" {
  vpc_id = aws_vpc.ada_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
}

resource "aws_route_table_association" "dados_a" {
  subnet_id      = aws_subnet.dados_a.id
  route_table_id = aws_route_table.banco.id

}

resource "aws_route_table_association" "dados_b" {
  subnet_id      = aws_subnet.dados_b.id
  route_table_id = aws_route_table.banco.id

}

resource "aws_route_table_association" "dados_c" {
  subnet_id      = aws_subnet.dados_c.id
  route_table_id = aws_route_table.banco.id

}

resource "aws_route_table" "privadaapp_a" {
  vpc_id = aws_vpc.ada_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_a.id
  }
}

resource "aws_route_table" "privadaapp_b" {
  vpc_id = aws_vpc.ada_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_b.id
  }
}

resource "aws_route_table" "privadaapp_c" {
  vpc_id = aws_vpc.ada_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_c.id
  }
}

resource "aws_route_table_association" "app_a" {
  subnet_id      = aws_subnet.privada_a.id
  route_table_id = aws_route_table.privadaapp_a.id

}

resource "aws_route_table_association" "app_b" {
  subnet_id      = aws_subnet.privada_b.id
  route_table_id = aws_route_table.privadaapp_b.id

}

resource "aws_route_table_association" "app_c" {
  subnet_id      = aws_subnet.privada_c.id
  route_table_id = aws_route_table.privadaapp_c.id

}
