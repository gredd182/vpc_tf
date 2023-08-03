variable "region" {
  description = "AWS region to deploy resources"
  default     = "ap-south-1" # Replace with your desired region
}

variable "availability_zone" {
  description = "AWS availability zone for the public subnet"
  default     = "ap-south-1a" # Replace with your desired availability zone
}
