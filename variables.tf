variable "region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "Pub_Sub_1_cidr" {
  type = string
}


variable "Pub_Sub_2_cidr" {
  type = string
}


variable "Priv_Sub_1_cidr" {
  type = string
}

variable "Priv_Sub_2_cidr" {
  type = string
}


variable "aws_instance_type" {
  type = string
}


variable "image_id" {
  type = string
}

variable "rds_name" {
  description = "Database name"
  type        = string
}

variable "rds_username" {
  type = string
}

variable "rds_password" {
  type      = string
  sensitive = true
}

