variable "instance_type" {
  description = "Type of the instance"
  type        = string
  default     = "t3.micro"
  
}


variable "instance_tag" {
  description = "Tag for the instance"
  type        = map(string)
  default     = {}
  
}
variable "project" {
  type        = string
}
variable "environment" {
  type        = string
}