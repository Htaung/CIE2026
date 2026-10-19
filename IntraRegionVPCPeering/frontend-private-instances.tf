data "aws_ami" "fe_private_instance_ami" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "frontend_private_instance01" {
  ami                    = data.aws_ami.fe_private_instance_ami.id
  instance_type          = var.fe_instance_type
  key_name               = aws_key_pair.fe_keypair.key_name
  subnet_id              = aws_subnet.frontend_private_subnet1.id
  vpc_security_group_ids = [aws_security_group.frontend_private_sgp_1.id]

  tags = {
    Name        = "${var.frontend_prefix}-private-instance01"
    environment = "${var.frontend_environment}"
  }
}


resource "aws_instance" "frontend_private_instance02" {
  ami                    = data.aws_ami.fe_private_instance_ami.id
  instance_type          = var.fe_instance_type
  key_name               = aws_key_pair.fe_keypair.key_name
  subnet_id              = aws_subnet.frontend_private_subnet2.id
  vpc_security_group_ids = [aws_security_group.frontend_private_sgp_2.id]

  tags = {
    Name        = "${var.frontend_prefix}-private-instance02"
    environment = "${var.frontend_environment}"
  }
}

resource "aws_instance" "frontend_private_instance03" {
  ami                    = data.aws_ami.fe_private_instance_ami.id
  instance_type          = var.fe_instance_type
  key_name               = aws_key_pair.fe_keypair.key_name
  subnet_id              = aws_subnet.frontend_private_subnet3.id
  vpc_security_group_ids = [aws_security_group.frontend_private_sgp_3.id]

  tags = {
    Name        = "${var.frontend_prefix}-private-instance03"
    environment = "${var.frontend_environment}"
  }
}