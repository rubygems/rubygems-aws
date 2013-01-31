server ENV["RUBYGEMS_EC2_APP"], :app, :web if ENV["RUBYGEMS_EC2_APP"]
server ENV["RUBYGEMS_EC2_DB1"], :db if ENV["RUBYGEMS_EC2_DB1"]
# server ENV["RUBYGEMS_EC2_DB2"], :db if ENV["RUBYGEMS_EC2_DB2"]
server ENV["RUBYGEMS_EC2_LB1"], :lb if ENV["RUBYGEMS_EC2_LB1"]
# server ENV["RUBYGEMS_EC2_LB2"], :lb if ENV["RUBYGEMS_EC2_LB2"]
set :user, 'ubuntu'
set :id_file, "#{ENV['HOME']}/.ssh/aws/rubygems.pem"
ssh_options[:keys] = [id_file]
set :environment_name, "ec2"
set :node_name, "app.rubygems.org"

set :chef_binary, "/usr/bin/chef-solo"
