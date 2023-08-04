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

# Create a security group with necessary ingress rules
resource "aws_security_group" "example" {
  name_prefix = "example-security-group-"
# Add custom description for the security group
  description = "Security group for MyEC2Instance"

  # Ingress rules
  ingress {
    description = "Allow HTTP traffic from load balancer"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["96.127.0.0/32"]  # Replace with your office IP range
  }

  # Add more ingress rules as needed

  # Egress rules (example: allow all outbound traffic)
  egress {
    description = "Allow outbound traffic to s3"
    from_port   = 80
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance with IMDSv2 token and encrypted root block device
resource "aws_instance" "example" {
  ami           = data.aws_ami.encrypted_ami.id
  instance_type = "t2.micro" # Replace with your desired instance type
  key_name      = "terraform" # Replace with the name of your key pair

  # Attach the security group to the instance
  vpc_security_group_ids = [aws_security_group.example.id]

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

# Enable VPC Flow Logs for VPC
resource "aws_flow_log" "vpc_flow_logs" {
  name           = "vpc-flow-logs"
  traffic_type   = "ALL"
  log_destination = "arn:aws:logs:ap-south-1:875667920160:log-group:/aws/vpc/flow-logs"

  # Replace "ap-south-1" and "123456789012" with your region and AWS account ID
  # The log destination must point to a CloudWatch Logs log group for storing the flow logs
  vpc_id         = aws_instance.example.vpc_security_group_ids[0]
}

# Output the public IP address of the EC2 instance
output "public_ip" {
  value = aws_instance.example.public_ip
}
