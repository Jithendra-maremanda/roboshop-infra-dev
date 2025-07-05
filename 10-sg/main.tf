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

#bastion security group rule to allow traffic from laptop
resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         =22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks  =  ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}