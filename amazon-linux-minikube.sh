#!/bin/bash

set -e

# Update system
sudo dnf update -y

# Install required packages
sudo dnf install -y docker wget conntrack

# Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker

# Download Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Make Minikube executable
chmod +x minikube-linux-amd64

# Install Minikube
sudo mv minikube-linux-amd64 /usr/local/bin/minikube

# Verify Minikube installation
minikube version

# Download kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Download checksum
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

# Verify checksum
echo "$(cat kubectl.sha256) kubectl" | sha256sum --check

# Make kubectl executable
chmod +x kubectl

# Install kubectl
sudo mv kubectl /usr/local/bin/

# Verify kubectl installation
kubectl version --client

# Start Minikube
sudo minikube start --driver=docker --force

# Check Minikube status
sudo minikube status

# Verify Kubernetes node
kubectl get nodes
