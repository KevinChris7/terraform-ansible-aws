# main.tf

# Data source - Availability Zones
data "aws_availability_zones" "present_azs" {
  state = "available"
}

# VPC Resource
resource "aws_vpc" "primary_vpc" {
  cidr_block           = var.VPC_CIDR
  enable_dns_hostnames = var.VPC_DNS_HOST

  tags = {
    Name = "primary"
  }
}


# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.primary_vpc.id
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.primary_vpc.id
  cidr_block              = var.PUBLIC_CIDR
  availability_zone       = data.aws_availability_zones.present_azs.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.primary_vpc.id
  cidr_block              = var.PUBLIC_CIDR_B
  availability_zone       = data.aws_availability_zones.present_azs.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet2"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnetA" {
  vpc_id            = aws_vpc.primary_vpc.id
  cidr_block        = var.PRIVATE_CIDR_A
  availability_zone = data.aws_availability_zones.present_azs.names[0]

  tags = {
    Name = "PrivateSubnet1"
  }
}

resource "aws_subnet" "private_subnetB" {
  vpc_id            = aws_vpc.primary_vpc.id
  cidr_block        = var.PRIVATE_CIDR_B
  availability_zone = data.aws_availability_zones.present_azs.names[1]

  tags = {
    Name = "PrivateSubnet2"
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.primary_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.primary_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    #gateway_id = aws_internet_gateway.igw.id  //Testing Purpose
    nat_gateway_id = aws_nat_gateway.ngw.id
  }
}

# Public Route Table Associations
resource "aws_route_table_association" "public_rt_assoc1" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_assoc2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_rt.id
}

# Private Route Table Associations
resource "aws_route_table_association" "private_rt_assoc1" {
  subnet_id      = aws_subnet.private_subnetA.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rt_assoc2" {
  subnet_id      = aws_subnet.private_subnetB.id
  route_table_id = aws_route_table.private_rt.id
}

# Elastic IP for NatGateway
resource "aws_eip" "eip" {
  vpc = true
}

# NatGateway
resource "aws_nat_gateway" "ngw" {
  subnet_id     = aws_subnet.public_subnet.id
  allocation_id = aws_eip.eip.id
}