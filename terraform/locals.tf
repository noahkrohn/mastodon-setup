locals {
  enabled        = false
  localdata      = jsondecode(file("${path.module}/variables.tfvars.json"))
}