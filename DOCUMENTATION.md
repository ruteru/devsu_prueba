# Demo DevOps Node.js Application

This repository contains a Node.js application that has been dockerized and deployed to a local Kubernetes cluster using Minikube. The CI/CD pipeline is configured using GitHub Actions.

[Cloud Diagram](diagram.png)

## Dockerization

The application has been dockerized with the following improvements:

- Non-root user execution
- Port exposure
- Healthcheck

## Deployment

The application is deployed to a local Kubernetes cluster using Minikube. The deployment configuration includes:

- 2 replicas
- Readiness and liveness probes
- Service of type NodePort
- Ingress resource

## CI/CD Pipeline

The CI/CD pipeline includes the following steps:

- Code Build
- Unit Tests
- Static Code Analysis
- Code Coverage
- Docker build and push
- Kubernetes deployment

## How to run

### Using CMD

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

### Using Terraform

To deploy the application using Terraform, follow these steps:

1. Initialize Terraform:
   ```sh
   terraform init
   ```

2. Plan the Infrastructure::
   ```sh
   terraform plan
   ```

3. Apply the Configuration:
   ```sh
   terraform apply
   ```

Ensure Minikube and kubectl are correctly installed and configured. Adjust paths in the Dockerfile and Terraform files as necessary. Make sure Docker and Kubernetes are running locally.
