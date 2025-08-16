module "components" {
  source = ""
  component = each.key
  rule_priority = each.value.rule_priority
}