data "aws_ami" "be_public_instance_ami" {

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

resource "aws_eip" "backend_public_instance_eip" {

  tags = {
    name        = "${var.backend_prefix}-public-instance-eip-${var.region}"
    environment = "${var.backend_environment}"
  }
}

resource "aws_eip_association" "be_public_instance_eip_assoc" {
  instance_id   = aws_instance.backend_public_instance01.id
  allocation_id = aws_eip.backend_public_instance_eip.id
}

resource "aws_instance" "backend_public_instance01" {
  ami                    = data.aws_ami.be_public_instance_ami.id
  instance_type          = var.be_instance_type
  key_name               = aws_key_pair.be_keypair.key_name
  subnet_id              = data.tfe_outputs.be_network.values.backend_pub_subnet1_id
  vpc_security_group_ids = [data.tfe_outputs.be_security.values.backend_public_sgp_1_id]

  tags = {
    Name        = "${var.backend_prefix}-public-instance01"
    environment = "${var.backend_environment}"
  }
}