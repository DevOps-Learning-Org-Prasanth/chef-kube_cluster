#
# Cookbook:: chef-kube_cluster
# Recipe:: default
#
# Copyright:: 2021, Prasanth, All Rights Reserved.

# Disable selinux
selinux_state 'disable' do
  action :disabled
  notifies :reboot_now, 'reboot[reboot_now]', :immediately
end

reboot 'reboot_now' do
  action :reboot_now
  reason 'Need a reboot after selinux is disabled'
end

firewall_rule 'kube_settings' do
  protocol :tcp
  port node['kube_cluster']['ports']
  command :allow
end

template '/etc/yum.repos.d/kubernetes.repo' do
  source 'kubernetes.repo.erb'
end

package 'kubeadm' do
  action :install
end

package 'docker' do
  action :install
end

service 'docker' do
  action [:enable, :start]
end

service 'kubelet' do
  action [:enable, :start]
end

bash 'disable_swap' do
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
