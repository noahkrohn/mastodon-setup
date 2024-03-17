terraform {
required_version = ">= 1.7.4"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.54.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.2"
    }
  }
}
