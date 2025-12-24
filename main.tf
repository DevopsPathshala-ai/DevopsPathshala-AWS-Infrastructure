module "vpc" {
  source = "git::https://github.com/DevopsPathshala-ai/Test-Project.git//VPC?ref=v1.1.0"
  vpc_cidr = "10.20.0.0/16"
 tags = {
    Environment = "qa"
    Project     = "Test-Project"
    Owner       = "DevopsPathshala"
    ManagedBy   = "Terraform"
  }
  public_subnets = {
    public-1 = {
      cidr = "10.20.1.0/24"
      az   = "us-east-1a"
    }
 
  }
  private_subnets = {
    private-1 = {
      cidr = "10.20.2.0/24"
      az   = "us-east-1a"
    }
 
  }

}
module "SG" {
  source = "git::https://github.com/DevopsPathshala-ai/Test-Project.git//SG?ref=v1.1.0"
  vpc_id = module.vpc.vpc_id
  sg_name = "qa-web-sg"
}
/*module "Ec2" {
  source = "./EC2"
  subnet_id = module.vpc.public_subnet_ids["public-1"]
  ami = var.ec2_ami
  instance_type = var.ec2_instance_type
  key_name = var.ec2_key_name
  security_group_ids = [module.SG.security_group_id]
  instance_name = var.ec2_instance_name
  user_data = templatefile("D:/Terraform-Modules/EC2/userdata.tpl", {})
  
}*/
