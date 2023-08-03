# Declare the AWS provider and region
provider "aws" {
  region = "ap-south-1" # Replace with your desired region
}

# Create an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0f5ee92e2d63afc18" # Replace with your desired AMI ID
  instance_type = "t2.micro" # Replace with your desired instance type
  key_name      = "terraform"

  tags = {
    Name = "MyEC2Instance"
  }
}

