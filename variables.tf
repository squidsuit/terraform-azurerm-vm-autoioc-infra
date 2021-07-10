variable "region" {
  type        = string
  description = "Region to which the infrastructure is being deployed"
  default     = "eastus2"
}

variable "application-name" {
  type        = string
  description = "The name of the deployed app. Used in naming resources and tagging."
  default     = "autoioc"
}

variable "environment" {
  type        = string
  description = "Environment name. Used in naming resources and tagging."
  default     = "prod"
}

variable "all-tags" {
  type = map(string)

  default = {
    foo = "bar"
  }
}

variable "vmadmin" {
  type = string
  description = "Admin name for the autoioc vm"
  default = "azureuser"
}