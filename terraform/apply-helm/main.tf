# Configure Terraform settings
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
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

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
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

resource "helm_release" "chatbot_release" {
  name  = "chatbot-release"
  chart = "${path.module}/k8s"

  namespace = var.namespace

  values = [file("${path.module}/values.yaml")]
}