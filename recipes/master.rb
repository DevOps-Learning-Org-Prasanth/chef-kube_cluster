include_recipe 'kube_cluster::common_installation'

# Initiate cluster

bash 'start_cluster' do
  code <<-EOH
    swapoff -a
    kubeadm init
    mkdir -p $HOME/.kube
    cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    chown $(id -u):$(id -g) $HOME/.kube/config
    export kubever=$(kubectl version | base64 | tr -d '\n')
    kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"
    EOH
end