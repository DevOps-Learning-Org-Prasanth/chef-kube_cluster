name 'worker_node'

default_source :supermarket

default['kube_cluster']['ports'] = %w(6783 10250 10255 3000-32767)

run_list 'kube_cluster::common_installation'

cookbook 'kube_cluster', path: '../'
