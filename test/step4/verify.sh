#!/bin/bash

kubectl --kubeconfig /etc/karmada/karmada-apiserver.config get clusters kind-member2 && kubectl --kubeconfig /etc/karmada/karmada-apiserver.config get clusters kind-member3

