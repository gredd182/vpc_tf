variable "region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1" # Replace with your desired region
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro" # Replace with your desired instance type
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0c55b159cbfafe1f0" # Replace with your desired AMI ID
}
