resource "aws_internet_gateway" "demo-project-igw" {
  vpc_id = aws_vpc.demp-project-vpc.id

  tags = {
    Name = "demo-project-igw"
  }
}



resource "aws_eip" "demo-project-eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "demo-project-nat" {
  allocation_id = aws_eip.demo-project-eip.id
  subnet_id     = aws_subnet.public-subnet-demo-project.id

  tags = {
    Name = "nat-gateway"
  }
}