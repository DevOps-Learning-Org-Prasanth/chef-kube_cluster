#
# Cookbook:: chef-kube_cluster
# Recipe:: default
#
# Copyright:: 2021, Prasanth, All Rights Reserved.

# Add kubernetes repo
template '/etc/yum.repos.d/kubernetes.repo' do
  source 'kubernetes.repo.erb'
end

# Disable selinux
selinux_state 'disable' do
  action :disabled
  notifies :reboot_now, 'reboot[reboot_now]', :immediately
end

reboot 'reboot_now' do
  not_if 'getenforce | grep -i "disabled"'
  action :reboot_now
  reason 'Need a reboot after selinux is disabled'
end

firewall 'default' do
  action :install
end

firewall_rule 'kube_settings' do
  protocol :tcp
  port node['kube_cluster']['ports']
  command :allow
end

package 'docker' do
  action :install
end

package 'kubeadm' do
  action :install
end

service 'docker' do
  action [:enable, :start]
end

service 'kubelet' do
  action [:enable, :start]
end
