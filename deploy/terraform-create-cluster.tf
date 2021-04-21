provider "aws" {
  region = "us-west-2"
}

data "aws_eks_cluster" "cluster" {
  name = module.eks-labguidone.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks-labguidone.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}

module "eks-labguidone" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "eks-labguidone"
  cluster_version = "1.18"
  subnets         = ["subnet-50f62c1a", "subnet-162a936e", "subnet-df8f0482"]
  vpc_id          = "vpc-3686aa4e"

  worker_groups = [
    {
	  name                          = "prod"
      instance_type                 = "t3.small"
      asg_desired_capacity          = 1
      asg_max_size  				= 5
	  root_volume_type 				= "gp2"
    },
	{
	  name                          = "prod-cpu"
      instance_type                 = "t3.medium"
      asg_desired_capacity          = 1
      asg_max_size  				= 5
	  root_volume_type 				= "gp2"
    },
  ]
}
