variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}
variable "zone_id" {
    description = "The ID of the Route 53 hosted zone"
    type        = string
    default = "Z07875261XFWESB6HKZDD"
  
}

variable "zone_name" {
    type        = string
    default = "stansrobotshop.site"
  
}