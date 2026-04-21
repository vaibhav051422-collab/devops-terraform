variable "instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "ami_id" {
  description = "AMI id for the EC2 instance"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
  default     = 1
}

variable "project_name" {
  description = "Project name used in tags and naming"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR range allowed for SSH"
  type        = string
}