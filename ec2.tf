resource "aws_instance" "public-instance" {
  ami                    = "ami-0160e8d70ebc43ee1"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  key_name               = "pract"
  tags = {
    Name = "Public-instance"
  }
}

resource "aws_instance" "private-instance" {
  ami                    = "ami-0160e8d70ebc43ee1"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private-subnet.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  key_name               = "pract"
  tags = {
    Name = "Private-instance"
  }
}
