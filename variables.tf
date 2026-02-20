variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "subnet_id" {
  description = "The Subnet ID where the instance will be launched"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro" # Burstable performance, good for VPNs
}

variable "ami_id" {
  description = "AMI ID (e.g., Ubuntu 22.04)"
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

variable "is_public" {
  description = "Whether to assign a public IP and open firewall to your IP"
  type        = bool
  default     = true
}

variable "allowed_ip" {
  description = "Your public IP (e.g., '1.2.3.4/32')"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ingress_rules" {
  description = "Map of ingress rules: { name = { port, protocol, cidr_blocks } }"
  type = map(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {} # Default to no extra rules
}

variable "tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default = {
    deployed_by = "terraform"
  }
}