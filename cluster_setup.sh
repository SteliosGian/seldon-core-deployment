#!/bin/bash

kind create cluster --name seldon  # Set up Kind

kubectl cluster-info --context kind-seldon  # Configure kubectl to use the cluster

kubectl label namespace default istio-injection=enabled  # Inject proxies and anything we dpeloy in that namespace

kubectl apply -f seldon/istio_deployment.yaml  # Create Istio gateway

kubectl create namespace seldon-system  # Create namespace for the seldon-core operator

# Install seldon-core
helm install seldon-core seldon-core-operator \
    --repo https://storage.googleapis.com/seldon-charts \
    --set usageMetrics.enabled=true \
    --set istio.enabled=true \
    --namespace seldon-system

kubectl port-forward -n istio-system svc/istio-ingressgateway 8080:80  # Local port forwarding
