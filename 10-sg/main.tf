module "frontend" {
    source          = "git::https://github.com/Jithendra-maremanda/terraform-aws-security-group.git?ref=main"
    vpc_id          = local.vpc_id
    project         = var.project
    environment     = var.environment
    sg_name         = var.frontend_sg_name
    sg_description  = var.frontend_sg_description
    
}

module "bastion" {
    source          = "git::https://github.com/Jithendra-maremanda/terraform-aws-security-group.git?ref=main"
    vpc_id          = local.vpc_id
    project         = var.project
    environment     = var.environment
    sg_name         = var.bastion_sg_name
    sg_description  = var.bastion_sg_description
}

module "backend_alb" {
    source          = "git::https://github.com/Jithendra-maremanda/terraform-aws-security-group.git?ref=main"
    vpc_id          = local.vpc_id
    project         = var.project
    environment     = var.environment
    sg_name         = "backend-alb"
    sg_description  = "for backend_alb"
    
    
}
module "vpn" {
    source          = "git::https://github.com/Jithendra-maremanda/terraform-aws-security-group.git?ref=main"
    vpc_id          = local.vpc_id
    project         = var.project
    environment     = var.environment
    sg_name         = "vpn"
    sg_description  = "for vpn"
    
}

#bastion security group rule to allow traffic from laptop
resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         =22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks  =  ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

#backend alb accepting connection from the my bastion host on port no 80
resource "aws_security_group_rule" "backend_alb_bastion" {
  type              = "ingress"
  from_port         =80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.backend_alb.sg_id
}

resource "aws_security_group_rule" "vpn_ssh" {
  type              = "ingress"
  from_port         =22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks  =  ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_https" {
  type              = "ingress"
  from_port         = 443
  to_port           =  443
  protocol          = "tcp"
  cidr_blocks  =  ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks  =  ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks  =  ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

#backend alb accepting connection from the my backend_alb_vpn  host on port no 80

resource "aws_security_group_rule" "backend_alb_vpn" {
  type              = "ingress"
  from_port         =80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.backend_alb.sg_id
}
