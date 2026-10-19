locals {
  fe_private_key_filename = "${var.frontend_prefix}-ssh-key.pem"
  be_private_key_filename = "${var.backend_prefix}-ssh-key.pem"
}

resource "tls_private_key" "fe_keypair" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "fe_keypair" {
  key_name   = local.fe_private_key_filename
  public_key = tls_private_key.fe_keypair.public_key_openssh
}

resource "tls_private_key" "be_keypair" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "be_keypair" {
  key_name   = local.be_private_key_filename
  public_key = tls_private_key.be_keypair.public_key_openssh
}



resource "local_file" "fe_private_keypair" {
  content         = tls_private_key.fe_keypair.private_key_openssh
  filename        = "${path.root}/keys/fe.pem"
  file_permission = "0400"
}


resource "local_file" "be_private_keypair" {
  content         = tls_private_key.be_keypair.private_key_openssh
  filename        = "${path.root}/keys/be.pem"
  file_permission = "0400"
}
