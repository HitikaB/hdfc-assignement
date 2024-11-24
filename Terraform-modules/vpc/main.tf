resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.vpc_instance_tenancy

  tags = {
    Name = var.vpc_name
  }
}


resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "uat-ig"
  }
}


resource "aws_eip" "eip-01" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat-01" {
  subnet_id     = aws_subnet.subnet01.id
  allocation_id = aws_eip.eip-01.id

  tags = {
    Name = "uat-nat"
  }
}

resource "aws_route_table" "priv-route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-01.id
  }

  tags = {
    Name = var.priv_route_table_name
  }
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.subnet03.id
  route_table_id = aws_route_table.priv-route.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.subnet04.id
  route_table_id = aws_route_table.priv-route.id
}

resource "aws_subnet" "subnet03" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.priv_subnet1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name = var.priv_subnet1_name
  }
}

resource "aws_subnet" "subnet04" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.priv_subnet2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name = var.priv_subnet2_name
  }
}


resource "aws_route_table" "pub-route" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.pub_route_table_name
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet01.id
  route_table_id = aws_route_table.pub-route.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet02.id
  route_table_id = aws_route_table.pub-route.id
}

resource "aws_route" "route-pub01" {
  route_table_id         = aws_route_table.pub-route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}


resource "aws_subnet" "subnet01" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub_subnet1_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_1

  tags = {
    Name = var.pub_subnet1_name
  }
}

resource "aws_subnet" "subnet02" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub_subnet2_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_2

  tags = {
    Name = var.pub_subnet2_name
  }
}


