variable "vpc_cidr_block" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidr_block" {
  description = "Name to be used on all the resources as identifier"
  type        = list(string)
  default     = []
}

variable "public_subnet_cidr_block" {
  description = "Name to be used on all the resources as identifier"
  type        = list(string)
  default     = []
}

variable "namespace_names" {
  default = ["data-pg1", "data-pg2"]
  type    = list(string)
}

variable "nginx_pod_name" {
  default = "eks-service"
  type    = string
}

variable "nginx_pod_image" {
  default = "nginx:latest"
  type    = string
}

variable "bucket" {
  type    = string
  default = "eks-mongodb-data"
}

variable "eks_name" {
  type = string
  default = "eks-cluster"
}
variable "addon_names" {
  description = "List of EKS addon names"
  type        = list(string)
  default     = ["vpc-cni", "coredns", "kube-proxy", "aws-ebs-csi-driver"]
}

variable "iam_user_name" {
  type = string
  default = "project-admin"
}

variable "config_path" {
  type = string
  description = "Kube config file path"
}

variable "config_context" {
  type = string
  description = "Name of the context"
}

variable "namespace" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = { "Name" = "" }
}

variable "allow_entities" {
  type = list
  default = ["project-admin", "qa", "developer"]
}

variable "entities" {
  type = map(any)
  default = {
    admin = {
      rule = {
        "api_groups" = [
          "*"]
        "resources" = [
          "*"]
        "verbs" = [
          "*"]
      }
    },
    developer = {
      rule = {
        "api_groups" = [
          "*"]
        "resources" = [
          "pods/log",
          "pods/portforward",
          "pods/exec",
          "cronjobs",
          "componentstatuses",
          "daemonsets",
          "deployments",
          "deployments/scale",
          "events",
          "ingress",
          "ingresses",
          "jobs",
          "limitranges",
          "nodes",
          "pods",
          "persistentvolumes",
          "persistentvolumeclaims",
          "services"
        ]
        "verbs" = [
          "*"]
      }
    },
    qa = {
      rule = {
        "api_groups" = [
          "*"]
        "resources" = [
          "pods/log",
          "pods/portforward",
          "pods/exec",
          "cronjobs",
          "componentstatuses",
          "daemonsets",
          "deployments",
          "deployments/scale",
          "events",
          "ingress",
          "ingresses",
          "jobs",
          "limitranges",
          "nodes",
          "pods",
          "persistentvolumes",
          "persistentvolumeclaims",
          "services"
        ]
        verbs = [
          "get",
          "list",
          "watch"]
      }
    }
  }
}
