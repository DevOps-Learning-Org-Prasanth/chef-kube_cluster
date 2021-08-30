name 'master_node'

default_source :supermarket

default['kube_cluster']['ports'] = [6443, 2379, 2380, 10250, 10251, 10252, 10255]

run_list 'kube_cluster::master'

cookbook 'kube_cluster', path: '../'
