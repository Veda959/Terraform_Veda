provider "aws" {
  region = var.aws_region  
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Create subnet
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

# Create Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# Create Route Table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
}

# Create a route to the internet
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# Associate the route table with the subnet
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

# Create Master instance Security Group
resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a Slave instance Security Group
resource "aws_security_group" "slave_sg" {
  name        = "slave-sg"
  description = "Allow SSH only from Jenkins_Master SG"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.main.id]
    description     = "SSH from Jenkins_Master SG"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "main" {
  ami           = var.ami_id          
  instance_type = var.instance_type   
  key_name      = var.key_name        
  subnet_id     = aws_subnet.main.id
  security_groups = [aws_security_group.main.id]

  tags = {
    Name = "Jenkins_Master"
  }
}

# Create another EC2 instance

resource "aws_instance" "main2" {
  ami           = var.ami_id          
  instance_type = var.instance_type   
  key_name      = var.key_name        
  subnet_id     = aws_subnet.main.id
  security_groups = [aws_security_group.slave_sg.id]

  tags = {
    Name = "Jenkins-Slave"
  }
}
