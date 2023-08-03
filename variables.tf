variable "region" {
  description = "AWS region to deploy resources"
  default     = "ap-south-1" # Replace with your desired region
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro" # Replace with your desired instance type
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0f5ee92e2d63afc18" # Replace with your desired AMI ID
}
variable "key_name" {
  default     =  "terraform"
