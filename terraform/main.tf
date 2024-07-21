resource "docker_image" "demo_devops_nodejs" {
  name = "demo-devops-nodejs:latest"
  build {
    dockerfile = "../Dockerfile"
  }
}

resource "kubernetes_deployment" "demo_devops_nodejs" {
  metadata {
    name = "demo-devops-nodejs"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "demo-devops-nodejs"
      }
    }

    template {
      metadata {
        labels = {
          app = "demo-devops-nodejs"
        }
      }

      spec {
        container {
          name  = "demo-devops-nodejs"
          image = docker_image.demo_devops_nodejs.latest
          port {
            container_port = 8000
          }

          env {
            name  = "NODE_ENV"
            value = "production"
          }

          liveness_probe {
            http_get {
              path = "/api/users"
              port = 8000
            }
            initial_delay_seconds = 30
            period_seconds         = 10
          }

          readiness_probe {
            http_get {
              path = "/api/users"
              port = 8000
            }
            initial_delay_seconds = 10
            period_seconds         = 5
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "demo_devops_nodejs_service" {
  metadata {
    name = "demo-devops-nodejs-service"
  }

  spec {
    selector = {
      app = "demo-devops-nodejs"
    }
    port {
      protocol   = "TCP"
      port        = 80
      target_port = 8000
      node_port   = 30000
    }
    type = "NodePort"
  }
}

resource "kubernetes_ingress" "demo_devops_ingress" {
  metadata {
    name = "demo-devops-ingress"
  }

  spec {
    rule {
      host = "localhost"
      http {
        path {
          path     = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.demo_devops_nodejs_service.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
