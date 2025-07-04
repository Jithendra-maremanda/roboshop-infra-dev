module "frontend" {
    source          = "git::https://github.com/Jithendra-maremanda/terraform-aws-security-group.git?ref=main"
    vpc_id          = local.vpc_id
    project         = var.project
    environment     = var.environment
    sg_name         = var.frontend_sg_name
    sg_description  = var.frontend_sg_description
    
}