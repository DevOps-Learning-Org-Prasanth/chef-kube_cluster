# Chef InSpec test for recipe chef-kube_cluster::default

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end
end

# This is an example test, replace it with your own test.
describe port(6443), :skip do
  it { should_not be_listening }
end

describe service('kubelet') do
  it { should be_installed }
  it { should be_enabled }
  # it { should be_running }
end

describe service('docker') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
