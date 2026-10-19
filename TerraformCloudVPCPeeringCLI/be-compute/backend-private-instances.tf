data "aws_ami" "be_private_instance_ami" {
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

resource "aws_instance" "backend_private_instance01" {
  ami                    = data.aws_ami.be_private_instance_ami.id
  instance_type          = var.be_instance_type
  key_name               = aws_key_pair.be_keypair.key_name
  subnet_id              = data.tfe_outputs.be_network.values.backend_private_subnet1_id
  vpc_security_group_ids = [data.tfe_outputs.be_security.values.backend_private_sgp_1_id]

  tags = {
    Name        = "${var.backend_prefix}-private-instance01"
    environment = "${var.backend_environment}"
  }
}


#####################################################
resource "aws_instance" "backend_private_instance02" {
  ami                    = data.aws_ami.be_private_instance_ami.id
  instance_type          = var.be_instance_type
  key_name               = aws_key_pair.be_keypair.key_name
  subnet_id              = data.tfe_outputs.be_network.values.backend_private_subnet2_id
  vpc_security_group_ids = [data.tfe_outputs.be_security.values.backend_private_sgp_2_id]

  tags = {
    Name        = "${var.backend_prefix}-private-instance02"
    environment = "${var.backend_environment}"
  }
}

resource "aws_instance" "backend_private_instance03" {
  ami                    = data.aws_ami.be_private_instance_ami.id
  instance_type          = var.be_instance_type
  key_name               = aws_key_pair.be_keypair.key_name
  subnet_id              = data.tfe_outputs.be_network.values.backend_private_subnet3_id
  vpc_security_group_ids = [data.tfe_outputs.be_security.values.backend_private_sgp_3_id]

  tags = {
    Name        = "${var.backend_prefix}-private-instance03"
    environment = "${var.backend_environment}"
  }
}