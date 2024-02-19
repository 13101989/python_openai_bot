# Deploy k8s config

```bash

# create space
helm create k8s

# set namespace
k create namespace chatbot
k get ns
k config set-context --current --namespace=chatbot
k config get-contexts

# lint
helm lint

# add all secrets in my-secret
kubectl create secret generic my-secret --from-env-file=.env
kubectl get secrets my-secret -o yaml
kubectl delete secret my-secret

# install chart
helm install chatbot .
helm uninstall chatbot

# use port-forward instead of NodePort option
k port-forward svc/chatbot 8000:8000 -n chatbot 
k port-forward svc/chatbot 8000:8000 8001:8001 5432:5432

# troubleshoot commands
k get pods
k get pods --show-labels
k logs chatbot-c4bd69558-k9mbm
k describe pods
k get services -n chatbot
k describe service chatbot


# Install Argo CD steps
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
brew install argocd
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# get initial password, user is admin
argocd admin initial-password -n argocd
```