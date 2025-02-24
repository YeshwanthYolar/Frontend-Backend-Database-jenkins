resource "aws_instance" "public_instance" {
  ami           = "ami-0e1bed4f06a3b463d" # Change to your desired AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public-subnet-demo-project.id
  associate_public_ip_address = true
  key_name = "demo-project"
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  depends_on = [ aws_instance.private_instance, aws_internet_gateway.demo-project-igw ]

  user_data = templatefile("frontend.sh", {
    private_ip = aws_instance.private_instance.private_ip
      })

  tags = {
    Name = "public-instance"
  }
}

resource "aws_instance" "private_instance" {
  ami           = "ami-0e1bed4f06a3b463d" # Change to your desired AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private-subnet-demo-project.id
  key_name = "demo-project"
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  
  depends_on = [ aws_route_table.private-demo-project,aws_nat_gateway.demo-project-nat ]
  user_data = file("my_sql.sh")

  tags = {
    Name = "private-instance"
  }
}

output "public_ip" {
  description = "ip of public instance"
  value = aws_instance.public_instance.public_ip
}

output "private_ip" {
  description = "ip of private instance"
value = aws_instance.private_instance.private_ip
}

