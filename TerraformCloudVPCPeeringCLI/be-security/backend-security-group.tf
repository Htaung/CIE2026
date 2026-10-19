resource "aws_security_group" "backend_public_sgp_1" {
  vpc_id      = data.tfe_outputs.be_network.values.backend_vpc_id

  tags = {
    Name = "${var.backend_prefix}-pub-sgp-01"
  }
}

resource "aws_vpc_security_group_ingress_rule" "be_public_sgp01_allow_ssh" {
  security_group_id = aws_security_group.backend_public_sgp_1.id
  cidr_ipv4         = "116.86.53.71/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "be_public_sgp01_allow_ping" {
  security_group_id = aws_security_group.backend_public_sgp_1.id
  cidr_ipv4         = "116.86.53.71/32"
  from_port         = 8
  ip_protocol       = "icmp"
  to_port           = 0
}

resource "aws_vpc_security_group_egress_rule" "be_public_sgp01_allow_all_traffic" {
security_group_id = aws_security_group.backend_public_sgp_1.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


################ pri-sgp-01 ############################################

resource "aws_security_group" "backend_private_sgp_1" {
  vpc_id      = data.tfe_outputs.be_network.values.backend_vpc_id

  tags = {
    Name = "${var.backend_prefix}-pri-sgp-01"
  }
}


resource "aws_vpc_security_group_ingress_rule" "be_private_sgp01_allow_ssh_pub_sgp_01" {
  security_group_id = aws_security_group.backend_private_sgp_1.id
  referenced_security_group_id = aws_security_group.backend_public_sgp_1.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sgp01_allow_ping_pub_sgp_01" {
  security_group_id = aws_security_group.backend_private_sgp_1.id
  referenced_security_group_id = aws_security_group.backend_public_sgp_1.id
  from_port         = 8
  ip_protocol       = "icmp"
  to_port           = 0
}

resource "aws_vpc_security_group_egress_rule" "be_private_sgp01_allow_all_traffic" {
 security_group_id = aws_security_group.backend_private_sgp_1.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
################ pri-sgp-01 ############################################


################ pri-sgp-02 ############################################

resource "aws_security_group" "backend_private_sgp_2" {
  vpc_id      = data.tfe_outputs.be_network.values.backend_vpc_id

  tags = {
    Name = "${var.backend_prefix}-pri-sgp-02"
  }
}


resource "aws_vpc_security_group_ingress_rule" "be_private_sgp02_allow_ssh_pri_sgp_01" {
  security_group_id = aws_security_group.backend_private_sgp_2.id
  referenced_security_group_id = aws_security_group.backend_private_sgp_1.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sgp02_allow_ping_pri_sgp_01" {
  security_group_id = aws_security_group.backend_private_sgp_2.id
  referenced_security_group_id = aws_security_group.backend_private_sgp_1.id
  from_port         = 8
  ip_protocol       = "icmp"
  to_port           = 0
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sgp02_allow_ssh_fe_pri_sgp_02" {
  security_group_id = aws_security_group.backend_private_sgp_2.id
  
  cidr_ipv4   = var.frontend_private_subnet_cidr_blocks[1]
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sgp02_allow_ping_fe_pri_sgp_02" {
  security_group_id = aws_security_group.backend_private_sgp_2.id
  
  cidr_ipv4   = var.frontend_private_subnet_cidr_blocks[1]
  from_port         = 8
  ip_protocol       = "icmp"
  to_port           = 0
}

resource "aws_vpc_security_group_egress_rule" "be_private_sgp02_outbound_allow_ping_fe_pri_sgp_02" {
  security_group_id = aws_security_group.backend_private_sgp_2.id
  cidr_ipv4   = var.frontend_private_subnet_cidr_blocks[1]
  from_port         = 8
  ip_protocol       = "icmp"
  to_port           = 0
}

resource "aws_vpc_security_group_egress_rule" "be_private_sgp02_outbound_allow_ssh_fe_pri_sgp_02" {
  security_group_id = aws_security_group.backend_private_sgp_2.id
  cidr_ipv4   = var.frontend_private_subnet_cidr_blocks[1]
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
################ pri-sgp-02 ############################################


################ pri-sgp-03 ############################################

resource "aws_security_group" "backend_private_sgp_3" {
  vpc_id      = data.tfe_outputs.be_network.values.backend_vpc_id

  tags = {
    Name = "${var.backend_prefix}-pri-sgp-03"
  }
}


resource "aws_vpc_security_group_ingress_rule" "be_private_sgp03_allow_ssh_pri_sgp_01" {
  security_group_id = aws_security_group.backend_private_sgp_3.id
  referenced_security_group_id = aws_security_group.backend_private_sgp_1.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sgp03_allow_ping_pri_sgp_01" {
  security_group_id = aws_security_group.backend_private_sgp_3.id
  referenced_security_group_id = aws_security_group.backend_private_sgp_1.id
  from_port         = 8
  ip_protocol       = "icmp"
  to_port           = 0
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sgp03_allow_ssh_fe_pri_sgp_03" {
  security_group_id = aws_security_group.backend_private_sgp_3.id
  
  cidr_ipv4   = var.frontend_private_subnet_cidr_blocks[2]
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sgp03_allow_ping_fe_pri_sgp_03" {
  security_group_id = aws_security_group.backend_private_sgp_3.id
  
  cidr_ipv4   = var.frontend_private_subnet_cidr_blocks[2]
  from_port         = 8
  ip_protocol       = "icmp"
  to_port           = 0
}

resource "aws_vpc_security_group_egress_rule" "be_private_sgp03_outbound_allow_ping_fe_pri_sgp_03" {
  security_group_id = aws_security_group.backend_private_sgp_3.id
  cidr_ipv4   = var.frontend_private_subnet_cidr_blocks[2]
  from_port         = 8
  ip_protocol       = "icmp"
  to_port           = 0
}

resource "aws_vpc_security_group_egress_rule" "be_private_sgp03_outbound_allow_ssh_fe_pri_sgp_03" {
  security_group_id = aws_security_group.backend_private_sgp_3.id
  cidr_ipv4   = var.frontend_private_subnet_cidr_blocks[2]
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
################ pri-sgp-03 ############################################