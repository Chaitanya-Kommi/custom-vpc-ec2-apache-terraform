resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.public-subnet
  availability_zone       = "eu-west-3a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = var.igw-cidr
    gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public-rt-subnet-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_subnet" "private-subnet" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = var.private-subnet
  availability_zone = "eu-west-3b"
  tags = {
    Name = "private-subnet"
  }
}

resource "aws_eip" "eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat-gate" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-subnet.id
  tags = {
    Name = "nat-gate"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block     = var.nat-cidr
    nat_gateway_id = aws_nat_gateway.nat-gate.id
  }
  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private-rt-subnet-association" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-sg"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}