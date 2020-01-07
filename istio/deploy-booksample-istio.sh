#!/bin/bash
# Set up of the Book application of istio for Microk8s
# https://istio.io/docs/examples/bookinfo/

# We enable istio and when prompted if enable TLS authentication between sidecars injection we say 'N'o
echo 'N;' | microk8s.enable istio

# TODO printout the http NodePort of the Istio IngressGateway with the URL of the app.
export PUBLIC_IP=$(curl -s ifconfig.me)

# We create a namespace for the application
kubectl create ns book
# We enable the injection in the book namespace
kubectl label namespace book istio-injection=enabled
# we install the book 
kubectl -n book apply -f . 

echo "The Book application is now available at http://$PUBLIC_IP :[http IstioIngressGwNodePort]/productpage"