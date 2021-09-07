# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options
current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "prasanth155518"
client_key               "#{current_dir}/prasanth155518.pem"
chef_server_url          "https://api.chef.io/organizations/chef_training155"
cookbook_path            ["../"]
knife[:editor] = "/usr/bin/vim"