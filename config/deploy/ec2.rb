server ENV["RUBYGEMS_EC2_APP"], :app, :web, :db
server ENV["RUBYGEMS_EC2_LB1"], :lb
# server ENV["RUBYGEMS_EC2_LB2"], :lb
set :user, 'ubuntu'
set :id_file, "#{ENV['HOME']}/.ssh/aws/rubygems.pem"
ssh_options[:keys] = [id_file]
set :environment_name, "ec2"
set :node_name, "app.rubygems.org"

set :chef_binary, "/usr/bin/chef-solo"

