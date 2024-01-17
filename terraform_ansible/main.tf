provider "aws" {
  region = "us-east-1" 
}

resource "aws_security_group" "security_group_bootcamp-carefour" {
  name        = "security_group_bootcamp"
  description = "Security Group para SSH, HTTP e porta 8000"

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

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  
  }

    ingress {
    from_port   = 8085
    to_port     = 8085
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 1433
    to_port     = 1433
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

resource "aws_instance" "bootcamp_carrefour_vm" {
  ami           = "ami-0c7217cdde317cfec"  # AMI do Ubuntu 22.04 
  instance_type = "t2.micro"  # Tipo de instância 
  key_name      = aws_key_pair.keypair_bootcamp.key_name

  vpc_security_group_ids = [aws_security_group.security_group_bootcamp-carefour.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y software-properties-common
              sudo apt-add-repository --yes --update ppa:ansible/ansible
              sudo apt-get install -y ansible

              # Copia a chave SSH para o diretório do usuário
              echo "${file("~/.ssh/id_rsa.pub")}" >> ~/.ssh/authorized_keys
              chmod 600 ~/.ssh/authorized_keys
              EOF

  tags = {
    Name        = "bootcamp_carrefour_vm"
    Environment = "dev"
    Application = "backend"
    Class       = "DevOps"
    Origem      = "hackweek"
  }
}  

resource "aws_eip" "bootcamp_carrefour_vm" {
  instance = aws_instance.bootcamp_carrefour_vm.id
}
