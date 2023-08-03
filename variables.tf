variable "region" {
  description = "AWS region to deploy resources"
  default     = "ap-south-1" # Replace with your desired region
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro" # Replace with your desired instance type
}

