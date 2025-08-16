module "components" {
  source = "https://github.com/Jithendra-maremanda/terraform-aws-roboshop.git"
  component = each.key
  rule_priority = each.value.rule_priority
}