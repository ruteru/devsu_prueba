# Demo DevOps Node.js Application

This repository contains a Node.js application that has been dockerized and deployed to a local Kubernetes cluster using Minikube. The CI/CD pipeline is configured using GitHub Actions.

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
