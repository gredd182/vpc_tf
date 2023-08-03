# Declare the AWS provider and region
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Replace with your desired AMI ID
  instance_type = "t2.micro" # Replace with your desired instance type

  tags = {
    Name = "MyEC2Instance"
  }
}

# Output the public IP address of the EC2 instance
output "public_ip" {
  value = aws_instance.example.public_ip
}
