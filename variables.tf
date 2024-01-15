variable "access_key" { 
  description = "AWS Access Key" 
  sensitive   = true 
} 
variable "secret_key" { 
  description = "AWS Secret Key" 
  sensitive   = true 
} 
variable "region" { 
  description = "AWS Region" 
  default     = "eu-north-1" 
} 
variable "ec2_ami" { 
  description = "AWS ID for OS image to be used" 
  # eu-north-1 listassa "Amazon Linux 2" 
  default = "ami-02aeff1a953c5c2ff" 
} 
variable "ec2_type" { 
  description = "Instance type for EC2" 
  # Using free tier eligible on EU-N-1 
  default = "t3.micro" 
} 
variable "ssh_public" { 
  description = "SSH public key for server access" 
  sensitive   = true 
} 
variable "ssh_key_name" { 
  description = "Name to identify SSH key name with on AWS" 
  sensitive   = true 
} 
