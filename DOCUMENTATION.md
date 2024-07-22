# Demo DevOps Node.js Application

This repository contains a Node.js application that has been dockerized and deployed to both a local Kubernetes cluster using Minikube and a public cloud environment using Azure. The CI/CD pipeline is configured using GitHub Actions.

[Cloud Diagram](diagram.png)

## Dockerization

The application has been dockerized with the following improvements:

- Non-root user execution
- Port exposure
- Healthcheck

## Deployment

### Local Deployment (Minikube)

For local development and testing, the application is deployed to a Kubernetes cluster running in Minikube. The deployment configuration includes:

- 2 replicas
- Readiness and liveness probes
- Service of type NodePort
- Ingress resource

### Cloud Deployment (Azure)

The application is also deployed to Azure Kubernetes Service (AKS) for production use. The Azure infrastructure includes the following components:

- **Resource Group**: A container for managing related Azure resources.
- **AKS (Azure Kubernetes Service)**: Manages and scales containerized applications with Kubernetes.
  - **Deployment**: Manages the deployment of application containers.
  - **Service**: Exposes the application within the Kubernetes cluster.
  - **Ingress**: Manages external access to the services in the AKS cluster.
- **ACR (Azure Container Registry)**: Stores Docker container images and allows for seamless integration with AKS.

## CI/CD Pipeline

The CI/CD pipeline is configured to automate the deployment process. It includes the following steps:

- Code Build
- Unit Tests
- Static Code Analysis
- Code Coverage
- Docker build and push
- Kubernetes deployment

### How to run

#### Local Deployment with Minikube

1. Start Minikube:

   ```sh
   minikube start
   ```

2. Deploy the application:

   ```sh
   kubectl apply -f deployment.yaml
   kubectl apply -f service.yaml
   kubectl apply -f ingress.yaml
   ```

3. Access the application:

   ```sh
   minikube service --all
   ```

#### Access the application:

Find the public endpoint of the application via the Azure Portal or by using Azure CLI commands to get the Ingress URL or Public IP. [Access Application]()
