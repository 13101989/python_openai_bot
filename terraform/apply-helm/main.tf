# Configure Terraform settings
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
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

resource "helm_release" "my_chatbot_release" {
  name    = "my-chatbot-release"
  chart   = "${path.module}/../../k8s/"
  version = "0.0.1"

  namespace = var.namespace

  values = [file("${path.module}/values.yaml")]
}