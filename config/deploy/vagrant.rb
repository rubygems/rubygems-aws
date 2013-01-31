server "33.33.33.10", :app, :web, :db
set :server_ip, "33.33.33.10"
set :user, 'vagrant'
set :id_file, "#{ENV['HOME']}/.vagrant.d/insecure_private_key"
ssh_options[:keys] = [id_file]
set :environment_name, "vagrant"
set :node_name, "vagrant-app"

set :chef_binary, "/usr/bin/chef-solo"

server "33.33.33.11", :lb
set :server_ip, "33.33.33.11"
set :user, 'vagrant'
set :id_file, "#{ENV['HOME']}/.vagrant.d/insecure_private_key"
ssh_options[:keys] = [id_file]
set :environment_name, "vagrant"
set :node_name, "vagrant-lb"

set :chef_binary, "/usr/bin/chef-solo"
