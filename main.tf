# Declare the AWS provider and region
provider "aws" {
  region = "ap-south-1" # Replace with your desired region
}

# Find an encrypted AMI ID in your desired region.
data "aws_ami" "encrypted_ami" {
  most_recent = true

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Replace with the appropriate AMI owner if necessary.
}

# Create an EC2 instance with IMDSv2 token and encrypted root block device
resource "aws_instance" "example" {
  ami           = data.aws_ami.encrypted_ami.id
  instance_type = "t2.micro" # Replace with your desired instance type
  key_name      = "terraform" # Replace with the name of your key pair

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "MyEC2Instance"
  }
}

# Output the public IP address of the EC2 instance
output "public_ip" {
  value = aws_instance.example.public_ip
}
