output "docker_image_name" {
  value = docker_image.demo_devops_nodejs.name
}

output "kubernetes_deployment_name" {
  value = kubernetes_deployment.demo_devops_nodejs.metadata[0].name
}

output "kubernetes_service_name" {
  value = kubernetes_service.demo_devops_nodejs_service.metadata[0].name
}

output "kubernetes_ingress_name" {
  value = kubernetes_ingress.demo_devops_ingress.metadata[0].name
}
