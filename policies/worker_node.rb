name 'worker_node'

default_source :supermarket

node['kube_cluster']['ports'] = [6783, 10250, 10255, 3000...32767]

run_list 'kube_cluster::worker'

cookbook 'kube_cluster', path: '../'
