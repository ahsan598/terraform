resource "aws_instance" "server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  # Attach the security group to the EC2 instance
  security_groups = [aws_security_group.sg.name]

  tags = {
    Name = var.instance_name
  }

  provisioner "file" {
    source      = "./modules/ec2/testfile.txt"
    destination = "/tmp/testfile.txt"

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file(var.private_key_path)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'File received successfully' >> /tmp/log.txt",    # Log the success
      "cat /tmp/testfile.txt",                                # Print the file content
      "sudo yum update -y",                                   # Example command: Update the 
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file(var.private_key_path)
    }

    on_failure = continue
  }

  provisioner "local-exec" {
    command = "echo 'Provisioning complete for instance: ${self.public_ip}'"  # Execute locally after provisioning
    on_failure = continue
  }
}

resource "aws_security_group" "sg" {
  name        = "MyInstanceSG"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}