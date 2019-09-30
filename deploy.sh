## /bin/bash
echo "What email would you like to use for LetsEncrypt?"

read -p "Email: " PERSONAL_EMAIL

terraform init setup/terraform

terraform apply setup/terraform

gcloud beta container clusters get-credentials vault-example-cluster --region us-east1 


kubectl --namespace kube-system create sa tiller
kubectl create clusterrolebinding tiller \
  --clusterrole cluster-admin \
  --serviceaccount=kube-system:tiller
helm init --service-account tiller

kubectl -n kube-system  rollout status deploy/tiller-deploy

helm install stable/cert-manager \
  --name cert-manager \
  --set ingressShim.defaultIssuerName=letsencrypt \
  --set ingressShim.defaultIssuerKind=ClusterIssuer \
  --namespace cert-manager \
  --version v0.5.2

  # create the ClusterIssuer. This CRD enables cert-manager to create letsEncrypt
# certs for each ingress.
cat << EOF | kubectl apply -n cert-manager -f -
apiVersion: certmanager.k8s.io/v1alpha1
kind: ClusterIssuer
metadata:
  name: letsencrypt
spec:
  acme:
    # The ACME server URL
    server: https://acme-v02.api.letsencrypt.org/directory
    # Email address used for ACME registration
    email: $PERSONAL_EMAIL
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: letsencrypt
    http01: {}
EOF

helm install setup/helm/rancher \
  --name rancher \
  --namespace cattle-system \

helm install setup/helm/vault

helm install setup/helm/concourse