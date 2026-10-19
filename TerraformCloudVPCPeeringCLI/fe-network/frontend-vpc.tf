resource "aws_vpc" "hc_frontend_vpc" {
  cidr_block = var.frontend_vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "${var.frontend_prefix}-vpc"
  }
}

resource "aws_subnet" "frontend_pub_subnet1" {
  vpc_id     = aws_vpc.hc_frontend_vpc.id
  cidr_block = var.frontend_pub_subnet_cidr_blocks[0]

  tags = {
    Name = "${var.frontend_prefix}-pub-subnet-1"
  }
}

resource "aws_subnet" "frontend_pub_subnet2" {
  vpc_id     = aws_vpc.hc_frontend_vpc.id
  cidr_block = var.frontend_pub_subnet_cidr_blocks[1]

  tags = {
    Name = "${var.frontend_prefix}-pub-subnet-2"
  }
}

resource "aws_subnet" "frontend_pub_subnet3" {
  vpc_id     = aws_vpc.hc_frontend_vpc.id
  cidr_block = var.frontend_pub_subnet_cidr_blocks[2]

  tags = {
    Name = "${var.frontend_prefix}-pub-subnet-3"
  }
}

resource "aws_subnet" "frontend_private_subnet1" {
  vpc_id     = aws_vpc.hc_frontend_vpc.id
  cidr_block = var.frontend_private_subnet_cidr_blocks[0]

  tags = {
    Name = "${var.frontend_prefix}-private-subnet-1"
  }
}

resource "aws_subnet" "frontend_private_subnet2" {
  vpc_id     = aws_vpc.hc_frontend_vpc.id
  cidr_block = var.frontend_private_subnet_cidr_blocks[1]

  tags = {
    Name = "${var.frontend_prefix}-private-subnet-2"
  }
}

resource "aws_subnet" "frontend_private_subnet3" {
  vpc_id     = aws_vpc.hc_frontend_vpc.id
  cidr_block = var.frontend_private_subnet_cidr_blocks[2]

  tags = {
    Name = "${var.frontend_prefix}-private-subnet-3"
  }
}

#############################################################
# IGW and Route Table
#############################################################

resource "aws_internet_gateway" "frontend_igw" {
  vpc_id = aws_vpc.hc_frontend_vpc.id

  tags = {
    Name = "${var.frontend_prefix}-igw"
  }
}

resource "aws_route_table" "frontend_public_rtb" {
  vpc_id = aws_vpc.hc_frontend_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.frontend_igw.id
  }

  tags = {
    Name = "${var.frontend_prefix}-public-rtb"
  }
}

resource "aws_route_table_association" "frontend_public_subnet1_association" {
  subnet_id      = aws_subnet.frontend_pub_subnet1.id
  route_table_id = aws_route_table.frontend_public_rtb.id
}

resource "aws_route_table_association" "frontend_public_subnet2_association" {
  subnet_id      = aws_subnet.frontend_pub_subnet2.id
  route_table_id = aws_route_table.frontend_public_rtb.id
}

resource "aws_route_table_association" "frontend_public_subnet3_association" {
  subnet_id      = aws_subnet.frontend_pub_subnet3.id
  route_table_id = aws_route_table.frontend_public_rtb.id
}

resource "aws_route_table" "frontend_private_rtb01" {
  vpc_id = aws_vpc.hc_frontend_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.frontend_ngw.id
  }

  tags = {
    Name = "${var.frontend_prefix}-private-rtb"
  }
}

resource "aws_route_table_association" "frontend_private_subnet1_association" {
  subnet_id      = aws_subnet.frontend_private_subnet1.id
  route_table_id = aws_route_table.frontend_private_rtb01.id
}


resource "aws_route_table" "frontend_private_rtb02" {
  vpc_id = aws_vpc.hc_frontend_vpc.id

  tags = {
    Name = "${var.frontend_prefix}-private-rtb02"
  }
}

resource "aws_route_table_association" "frontend_private_subnet02_association" {
  subnet_id      = aws_subnet.frontend_private_subnet2.id
  route_table_id = aws_route_table.frontend_private_rtb02.id
}

resource "aws_route_table" "frontend_private_rtb03" {
  vpc_id = aws_vpc.hc_frontend_vpc.id



  tags = {
    Name = "${var.frontend_prefix}-private-rtb03"
  }
}

resource "aws_route_table_association" "frontend_private_subnet03_association" {
  subnet_id      = aws_subnet.frontend_private_subnet3.id
  route_table_id = aws_route_table.frontend_private_rtb03.id
}


#############################################################
# NAT Gateway and Route Table
#############################################################

resource "aws_eip" "frontend_natgw_eip" {

  tags = {
    name        = "${var.frontend_prefix}-natgw-eip-${var.region}"
    environment = "${var.frontend_environment}"
  }
}

resource "aws_nat_gateway" "frontend_ngw" {

  allocation_id = aws_eip.frontend_natgw_eip.id
  subnet_id     = aws_subnet.frontend_pub_subnet1.id

  depends_on = [
    aws_eip.frontend_natgw_eip
  ]

  tags = {
    name        = "${var.frontend_prefix}-natgw-${var.region}"
    environment = "${var.frontend_environment}"
  }
}




