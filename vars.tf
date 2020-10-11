variable "aws_access_key" {
  description = "Amazon Web Server(AWS) access key"
  default = "your aws access key"
}

variable "aws_secret_access_key" {
  description = "Amazon Web Server(AWS) secret access key"
  default = "your aws secret access key"
}

variable "region" {
  description = "Amazon Region"
  default = "us-east-1"
}

variable "instance_type" {
  description = "Amazon Instance Type"
  default = "t2.micro"
}

variable "vpc_id" {
  description = "Amazon VPC id"
  default = "vpc-283bdb55"
}

variable "subnet_id_1a" {
  description = "Amazon Singapore Subnet ID"
  default = "subnet-c204638f"
}

variable "subnet_id_1b" {
  description = "Amazon Singapore Subnet ID"
  default = "subnet-5b9b4b04"
}

variable "subnet_id_1c" {
  description = "Amazon Singapore Subnet ID"
  default = "subnet-e003d786"
}

variable "ami_id" {
  description = "Amazon OS ID"
  default = "ami-098f16afa9edf40be"
}

variable "vpc_security_group_ids" {
  description = "Amazon Security Group"
  default = "sg-0edbcb3cc1394dc25"
}

variable "key_name" {
  description = "Amazon Key Name"
  default = "web-db-key"
}

variable "availability_zone_1a" {
  description = "Amazon Availibility Zone"
  default = "us-east-1a"
}

variable "availability_zone_1b" {
  description = "Amazon Availibility Zone"
  default = "us-east-1b"
}

variable "availability_zone_1c" {
  description = "Amazon Availibility Zone"
  default = "us-east-1c"
}
