#!/bin/bash

set -e

#Updating Ubuntu Packages
sudo apt update -y
sudo apt upgrade -y

#Installing Required Packages
sudo apt install -y curl wget apt-transport-https ca-certificates

#Installing Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

#Enabling Docker
sudo systemctl enable docker
sudo systemctl start docker

#Installing Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo install minikube-linux-amd64 /usr/local/bin/minikube

#Minikube Version
minikube version

#Installing kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

echo "$(cat kubectl.sha256) kubectl" | sha256sum --check

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

#kubectl Version
kubectl version --client

#Starting Minikube
sudo minikube start --driver=docker --force
#Cluster Status
sudo minikube status
#Nodes
kubectl get nodes
