variable "vpc_cidr_block" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidr_block" {
  description = "Name to be used on all the resources as identifier"
  type        = list(string)
  default     = []
}

variable "public_subnet_cidr_block" {
  description = "Name to be used on all the resources as identifier"
  type        = list(string)
  default     = []
}