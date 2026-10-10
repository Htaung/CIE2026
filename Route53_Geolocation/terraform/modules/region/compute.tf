data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "jump" {
  ami                         = data.aws_ssm_parameter.al2023.value
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public[0].id          # public subnet az1
  vpc_security_group_ids      = [aws_security_group.jump.id]
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = true

  tags = { Name = "jump-${var.name}" }
}

resource "aws_instance" "app" {
  count                  = 2
  ami                    = data.aws_ssm_parameter.al2023.value
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private[count.index].id    # private az1, az2
  vpc_security_group_ids = [aws_security_group.app.id]
  key_name               = aws_key_pair.this.key_name

  user_data = <<-EOF
    #!/bin/bash
    dnf install -y nginx
    echo "Hello from ${var.name} app${count.index + 1}" > /usr/share/nginx/html/index.html
    systemctl enable --now nginx
  EOF

  # dnf needs the NAT route to be ready on first boot
  depends_on = [
    aws_nat_gateway.this,
    aws_route_table_association.private,
  ]

  tags = { Name = "app-${var.name}-az${count.index + 1}" }
}