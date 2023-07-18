provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
provider "kubernetes" {
  config_path    = "~/.kube/config"
}

resource "helm_release" "spacebeacon" {
  name       = "spacebeacon-release"
  chart      = "spacebeacon"
  repository = "."
}

data "kubernetes_service_v1" "service-name" {
  metadata {
    name = "flaskapp"
    namespace = "prod"
  }
}

output "service-op" {
  value = data.kubernetes_service_v1.service-name.status[0]["load_balancer"][0]["ingress"][0]["hostname"]
}