#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# variable define
kind_version=v0.17.0
host_cluster_ip=172.30.1.2 #host node where Karmada is located
local_ip=127.0.0.1
KUBECONFIG_PATH=${KUBECONFIG_PATH:-"${HOME}/.kube"}

function installKind() {
    cat << EOF > installKind.sh
    wget https://github.com/kubernetes-sigs/kind/releases/download/${kind_version}/kind-linux-amd64
    chmod +x kind-linux-amd64
    sudo mv kind-linux-amd64 /usr/local/bin/kind
EOF

    sh installKind.sh
}

function cluster1Config() {
    touch cluster1.yaml
    cat << EOF > cluster1.yaml
    kind: Cluster
    apiVersion: kind.x-k8s.io/v1alpha4
    networking:
      apiServerAddress: "${host_cluster_ip}"
      apiServerPort: 6441
EOF
}

function cluster2Config() {
    touch cluster2.yaml
    cat << EOF > cluster2.yaml 
    kind: Cluster
    apiVersion: kind.x-k8s.io/v1alpha4
    networking:
      apiServerAddress: "${host_cluster_ip}"
      apiServerPort: 6442
EOF
}

function cluster3Config() {
    touch cluster3.yaml
    cat << EOF > cluster3.yaml
    kind: Cluster
    apiVersion: kind.x-k8s.io/v1alpha4
    networking:
      apiServerAddress: "${host_cluster_ip}"
      apiServerPort: 6443
EOF
}

# install kind and create member clusters
installKind

while [ ! -e /usr/local/bin/kind ]
do
  echo "waiting for kind are ready..."
done

# create cluster yaml
cluster1Config
cluster2Config
cluster3Config

# prepare for faster kind create cluster
docker pull kindest/node:v1.25.3

# clean screen 
clear
