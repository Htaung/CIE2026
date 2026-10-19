data "aws_ami" "fe_public_instance_ami" {

  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0*-x86_64-gp2"]
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

resource "aws_eip" "frontend_public_instance_eip" {

  tags = {
    name        = "${var.frontend_prefix}-public-instance-eip-${var.region}"
    environment = "${var.frontend_environment}"
  }
}

resource "aws_eip_association" "fe_public_instance_eip_assoc" {
  instance_id   = aws_instance.frontend_public_instance01.id
  allocation_id = aws_eip.frontend_public_instance_eip.id
}

resource "aws_instance" "frontend_public_instance01" {
  ami                    = data.aws_ami.fe_public_instance_ami.id
  instance_type          = var.fe_instance_type
  key_name               = aws_key_pair.fe_keypair.key_name
  subnet_id              = aws_subnet.frontend_pub_subnet1.id
  vpc_security_group_ids = [aws_security_group.frontend_public_sgp_1.id]

  tags = {
    Name        = "${var.frontend_prefix}-public-instance01"
    environment = "${var.frontend_environment}"
  }
}