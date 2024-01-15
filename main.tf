terraform { 
  required_providers { 
    aws = { 
      source  = "hashicorp/aws" 
      version = "~> 4.16" 
    } 
  } 
  required_version = ">= 1.2.0" 
} 

# Käytettävä region 
provider "aws" { 
  region = "eu-north-1" 
} 

# EC2-instanssin määrittely 
resource "aws_instance" "app_server" { 
  ami                    = "ami-02aeff1a953c5c2ff" 
  instance_type          = "t3.micro" 
  vpc_security_group_ids = [aws_security_group.ProjektityoSecurityGroup.id] 
  key_name               = "ProjektityoKeyPair" 

# Apachen asennuksen määrittely 
  user_data = <<-EOF 
  #!/bin/bash 
  cd /tmp 
  yum update -y 
  yum install -y httpd 
  echo "Hello from the EC2 instance Projektityö!" > /var/www/html/index.html 
  systemctl start httpd 
  EOF 

  tags = { 
    Name = "ProjektityoServerInstance" 
  } 
} 

# Security Groupin asetukset 
resource "aws_security_group" "ProjektityoSecurityGroup" { 
  name        = "ProjekityoSecurityGroup" 
  description = "Allow SSH and HTTP/HTTPS" 

# Saapuvan liikenteen salliminen 
  ingress { 
    description = "SSH" 
    from_port   = 22 
    to_port     = 22 
    protocol    = "tcp" 
    cidr_blocks = ["0.0.0.0/0"] 
    ipv6_cidr_blocks = ["::/0"] 
  } 

  ingress { 
    description = "HTTP" 
    from_port   = 80 
    to_port     = 80 
    protocol    = "tcp" 
    cidr_blocks = ["0.0.0.0/0"] 
    ipv6_cidr_blocks = ["::/0"] 
  } 

  ingress { 
    description = "HTTPS" 
    from_port   = 443 
    to_port     = 443 
    protocol    = "tcp" 
    cidr_blocks = ["0.0.0.0/0"] 
    ipv6_cidr_blocks = ["::/0"] 
  } 

# Lähtevän liikenteen salliminen 
  egress { 
    description = "outside" 
    from_port        = 0 
    to_port          = 0 
    protocol         = "-1" 
    cidr_blocks      = ["0.0.0.0/0"] 
    ipv6_cidr_blocks = ["::/0"] 
  } 

  tags = { 
    Name = "ProjektityoSecurityGroup" 
  } 
} 
