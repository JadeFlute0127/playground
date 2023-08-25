### Background：

1. The kubeconfig files for the member1 cluster, member2 cluster and member3 cluster are located in the $HOME/.kube directory. These files are named config-member1, config-member2 and config-member3 respectively.

   ```shell
      $HOME/.kube/config-member1
      $HOME/.kube/config-member2
      $HOME/.kube/config-member3
   ```
2. prepare for Lab environment

   - RUN `sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl`{{exec}}   

3. create clusters with kind

   - RUN `kind create cluster --name=member1 --config=cluster1.yaml --image=kindest/node:v1.25.3`{{exec}}
   - RUN `kind create cluster --name=member2 --config=cluster2.yaml --image=kindest/node:v1.25.3`{{exec}}
   - RUN `kind create cluster --name=member3 --config=cluster3.yaml --image=kindest/node:v1.25.3`{{exec}}

4. Check whether the member cluster is ready

   - RUN `kubectl --kubeconfig=$HOME/.kube/config config get-contexts`{{exec}}
