server ENV["RUBYGEMS_EC2"], :app, :web, :db
set :server_ip, ENV["RUBYGEMS_EC2"]
set :user, 'ubuntu'
set :id_file, "#{ENV['HOME']}/.ssh/aws/rubygems.pem"
ssh_options[:keys] = [id_file]
set :environment_name, "ec2"
set :node_name, "app.rubygems.org"

set :chef_binary, "/usr/bin/chef-solo"

