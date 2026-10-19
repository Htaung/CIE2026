resource "aws_vpc" "hc_backend_vpc" {
  cidr_block = var.backend_vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "${var.backend_prefix}-vpc"
  }
}

resource "aws_subnet" "backend_pub_subnet1" {
  vpc_id     = aws_vpc.hc_backend_vpc.id
  cidr_block = var.backend_pub_subnet_cidr_blocks[0]

  tags = {
    Name = "${var.backend_prefix}-pub-subnet-1"
  }
}

resource "aws_subnet" "backend_pub_subnet2" {
  vpc_id     = aws_vpc.hc_backend_vpc.id
  cidr_block = var.backend_pub_subnet_cidr_blocks[1]

  tags = {
    Name = "${var.backend_prefix}-pub-subnet-2"
  }
}

resource "aws_subnet" "backend_pub_subnet3" {
  vpc_id     = aws_vpc.hc_backend_vpc.id
  cidr_block = var.backend_pub_subnet_cidr_blocks[2]

  tags = {
    Name = "${var.backend_prefix}-pub-subnet-3"
  }
}

resource "aws_subnet" "backend_private_subnet1" {
  vpc_id     = aws_vpc.hc_backend_vpc.id
  cidr_block = var.backend_private_subnet_cidr_blocks[0]

  tags = {
    Name = "${var.backend_prefix}-private-subnet-1"
  }
}

resource "aws_subnet" "backend_private_subnet2" {
  vpc_id     = aws_vpc.hc_backend_vpc.id
  cidr_block = var.backend_private_subnet_cidr_blocks[1]

  tags = {
    Name = "${var.backend_prefix}-private-subnet-2"
  }
}

resource "aws_subnet" "backend_private_subnet3" {
  vpc_id     = aws_vpc.hc_backend_vpc.id
  cidr_block = var.backend_private_subnet_cidr_blocks[2]

  tags = {
    Name = "${var.backend_prefix}-private-subnet-3"
  }
}

#############################################################
# IGW and Route Table
#############################################################

resource "aws_internet_gateway" "backend_igw" {
  vpc_id = aws_vpc.hc_backend_vpc.id

  tags = {
    Name = "${var.backend_prefix}-igw"
  }
}

resource "aws_route_table" "backend_public_rtb" {
  vpc_id = aws_vpc.hc_backend_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.backend_igw.id
  }

  tags = {
    Name = "${var.backend_prefix}-public-rtb"
  }
}

resource "aws_route_table_association" "backend_public_subnet1_association" {
  subnet_id      = aws_subnet.backend_pub_subnet1.id
  route_table_id = aws_route_table.backend_public_rtb.id
}

resource "aws_route_table_association" "backend_public_subnet2_association" {
  subnet_id      = aws_subnet.backend_pub_subnet2.id
  route_table_id = aws_route_table.backend_public_rtb.id
}

resource "aws_route_table_association" "backend_public_subnet3_association" {
  subnet_id      = aws_subnet.backend_pub_subnet3.id
  route_table_id = aws_route_table.backend_public_rtb.id
}

resource "aws_route_table" "backend_private_rtb_01" {
  vpc_id = aws_vpc.hc_backend_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.backend_ngw.id
  }

  tags = {
    Name = "${var.backend_prefix}-private-rtb"
  }
}

resource "aws_route_table_association" "backend_private_subnet1_association" {
  subnet_id      = aws_subnet.backend_private_subnet1.id
  route_table_id = aws_route_table.backend_private_rtb_01.id
}


resource "aws_route_table" "backend_private_rtb02" {
  vpc_id = aws_vpc.hc_backend_vpc.id

  #   route {
  #     cidr_block = "0.0.0.0/0"
  #     gateway_id = aws_internet_gateway.backend_igw.id
  #   }

  tags = {
    Name = "${var.backend_prefix}-private-rtb02"
  }
}

resource "aws_route_table_association" "backend_private_subnet02_association" {
  subnet_id      = aws_subnet.backend_private_subnet2.id
  route_table_id = aws_route_table.backend_private_rtb02.id
}

resource "aws_route_table" "backend_private_rtb03" {
  vpc_id = aws_vpc.hc_backend_vpc.id


  tags = {
    Name = "${var.backend_prefix}-private-rtb03"
  }
}

resource "aws_route_table_association" "backend_private_subnet03_association" {
  subnet_id      = aws_subnet.backend_private_subnet3.id
  route_table_id = aws_route_table.backend_private_rtb03.id
}



#############################################################
# NAT Gateway and Route Table
#############################################################

resource "aws_eip" "backend_natgw_eip" {

  tags = {
    name        = "${var.backend_prefix}-natgw-eip-${var.region}"
    environment = "${var.backend_environment}"
  }
}

resource "aws_nat_gateway" "backend_ngw" {

  allocation_id = aws_eip.backend_natgw_eip.id
  subnet_id     = aws_subnet.backend_private_subnet1.id

  depends_on = [
    aws_eip.backend_natgw_eip
  ]

  tags = {
    name        = "${var.backend_prefix}-natgw-${var.region}"
    environment = "${var.backend_environment}"
  }
}