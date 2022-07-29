#!/bin/bash
wget: `#!bash wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash`
k3d cluster create mycluster

echo "✅ k3s server is ready"
sudo curl -o /usr/bin/kubectl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo chmod +x /usr/bin/kubectl
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

helm repo add haproxytech https://haproxytech.github.io/helm-charts
helm repo update
helm install haproxy-ingress haproxytech/kubernetes-ingress -n haproxy-ingress --create-namespace

echo "✅ added haproxy as IngressController"

kubectl get pods --all-namespaces

touch "${k3sreadylock}"
