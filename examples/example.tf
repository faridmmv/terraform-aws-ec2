module "wireguard_vm" {
  source    = "./modules/terraform-aws-ec2"
  is_public = true
  ami_id    = "ami-0abcdef1234567890" # Example Ubuntu AMI
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id
  key_name  = "my-aws-key"

  # Passing rules dynamically as requested
  ingress_rules = {
    "ssh" = {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["${var.my_ip}/32"]
    },
    "wireguard" = {
      port        = 51820
      protocol    = "udp"
      cidr_blocks = ["${var.my_ip}/32"]
    }
  }
}