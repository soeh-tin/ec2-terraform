provider "aws" {
  region = "us-east-2" # change to your preferred region
}

# Generate a new SSH key pair (For the first time user)
resource "tls_private_key" "ec2_one_tls_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Upload the public key to AWS as a Key Pair
resource "aws_key_pair" "ec2_one_key_pair" {
  key_name   = "ec2-one-key-pair"
  public_key = tls_private_key.ec2_one_tls_key.public_key_openssh
}

# Save the private key locally so you can SSH later
resource "local_file" "ec2_one_key_pair" {
  content  = tls_private_key.ec2_one_tls_key.private_key_pem
  filename = "D:/01_GitHub_Repository/ec2-terraform/ec2-one-key-pair.pem" # change your folder path in your local PC.
  file_permission = "0600"
}

# Create a security group allowing SSH
resource "aws_security_group" "ec2_one_sg" {
  name        = "ec2-one-sg"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # open SSH to all (not recommended for production)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 instance
resource "aws_instance" "ec2_one" {
  ami           = "ami-0b1dcb5abc47cd8b5" # Amazon Linux 2023 kernel-6.12 AMI (change based on region)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ec2_one_key_pair.key_name
  security_groups = [aws_security_group.ec2_one_sg.name]

  tags = {
    Name = "ec2-one"
  }
}