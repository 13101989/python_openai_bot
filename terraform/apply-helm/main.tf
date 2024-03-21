# Configure Terraform settings
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.8.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.17.0"
    }
  }

  cloud {
    organization = "my-skillab"

    workspaces {
      name = "chatbot"
    }
  }
}


provider "aws" {
  region = var.region
}

data "terraform_remote_state" "eks" {
  backend = "local"
  config = {
    path = "eks-cluster-state/terraform.tfstate"
  }
}

data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
    command     = "aws"
  }
}


resource "kubernetes_secret" "my_secret" {
  metadata {
    name      = "my-secret"
    namespace = var.namespace
  }

  data = {
    OPENAI_KEY        = var.REST_CLIENT_SECRET
    POSTGRES_DB       = var.POSTGRES_DB
    POSTGRES_USER     = var.POSTGRES_USER
    POSTGRES_PASSWORD = var.POSTGRES_PASSWORD
    POSTGRES_HOST     = var.POSTGRES_HOST
  }
}


provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
  }
}


resource "helm_release" "chatbot_release" {
  name  = "chatbot-release"
  chart = "${path.module}/k8s"

  namespace = var.namespace

  values = [file("${path.module}/values.yaml")]
}