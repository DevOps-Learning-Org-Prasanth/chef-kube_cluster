# chef-kube_cluster
This will be used to initialize a kubernetes cluster
reference: https://www.tecmint.com/install-kubernetes-cluster-on-centos-7/

## Steps
1. initialize chef cookbook
    - chef generate cookbook `<cookbook name>`
2. Create Recipes
3. Create policies
4. Kitchen test(dokken)
5. Write actions file to upload to supermarket

### Create Recipes
1. Disable Selinux ==> might be in gcp's startup script or selinux cookbook(test if restart is needed)** test if works without reboot
    - https://supermarket.chef.io/cookbooks/selinux
    - https://github.com/sous-chefs/selinux/blob/main/documentation/selinux_state.md
    - https://docs.chef.io/resources/reboot/
2. Set Firewall rules on port
    - Different for master and worker nodes
    - https://supermarket.chef.io/cookbooks/firewall
    ```
        firewall-cmd --permanent --add-port=6443/tcp
        firewall-cmd --permanent --add-port=2379-2380/tcp
        firewall-cmd --permanent --add-port=10250/tcp
        firewall-cmd --permanent --add-port=10251/tcp
        firewall-cmd --permanent --add-port=10252/tcp
        firewall-cmd --permanent --add-port=10255/tcp
        firewall-cmd –reload
        modprobe br_netfilter
        echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
    ```
3. Setup kubernetes yum pkg repo: template file
4. Install packages kubeadm,docker
5. enable and start the following services
    - kubelet
    - docker
6. Disable swap : `swapoff -a`
7. initialize kubernetes master: `kubeadm init`
8. Start cluster as root
9. Setup pod network using weavenet- pod network??
8. Copy the adm join: try storing token and sha256 in gcp secret store manager - todo once looking if it's possible

### Policies
We will need two policies one for master node and another for worker node

### kitchen tests
- status of docker kubelet servcies
-test if the number of lines with `NotReady` is zero or not using grep??. Op of kubelet get nodes.  

### actions
- Add chef_pem key to secrets.
- create a folder with knife config.rb
- apply knife cookbook upload
