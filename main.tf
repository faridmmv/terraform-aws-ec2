resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_security_group" "vpn_sg" {
  name   = "access-sg-${random_string.suffix.result}"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.key
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "vpn_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.vpn_sg.id]
  key_name               = var.key_name

  associate_public_ip_address = var.is_public

  tags = merge(
    {
      Name = "${random_string.suffix.result}-vm"
    },
    var.tags
  )
}