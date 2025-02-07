resource "aws_route_table" "public-demo-project-rt" {
  vpc_id = aws_vpc.demp-project-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-project-igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public-subnet-demo-project.id
  route_table_id = aws_route_table.public-demo-project-rt.id
}



resource "aws_route_table" "private-demo-project" {
  vpc_id = aws_vpc.demp-project-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.demo-project-nat.id
  }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private-subnet-demo-project.id
  route_table_id = aws_route_table.private-demo-project.id
}
