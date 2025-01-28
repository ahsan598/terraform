resource "aws_instance" "server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }

  # provisioner "local-exec" {
  #   command = "echo '${self.public_ip}' >> instance_ip.txt"
  # }


  provisioner "local-exec" {
    command = "echo 'EC2 instance created with ID: ${self.id}' >> create.log"
    when    = create
    on_failure = continue    
  }

  provisioner "local-exec" {
    command = "echo 'EC2 instance destroyed: ${self.id}' >> destroy.log"
    when    = destroy
    on_failure = continue
  }
}