server ENV["RUBYGEMS_EC2_APP"], :app, :web if ENV["RUBYGEMS_EC2_APP"]
server ENV["RUBYGEMS_EC2_DB1"], :dbmaster if ENV["RUBYGEMS_EC2_DB1"]
# server ENV["RUBYGEMS_EC2_DB2"], :db if ENV["RUBYGEMS_EC2_DB2"]
server ENV["RUBYGEMS_EC2_LB1"], :balancer if ENV["RUBYGEMS_EC2_LB1"]
# server ENV["RUBYGEMS_EC2_LB2"], :lb if ENV["RUBYGEMS_EC2_LB2"]

abort("Must have DEPLOY_USER environment variable") unless ENV['DEPLOY_USER']
set :user, ENV['DEPLOY_USER']
abort("Must have DEPLOY_SSH_KEY environment variable") unless ENV['DEPLOY_SSH_KEY']
set :id_file, ENV['DEPLOY_SSH_KEY']
ssh_options[:keys] = [id_file]
set :environment_name, "rubygems.org"
#set :node_name, "rubygems.org"

set :chef_binary, "/usr/bin/chef-solo"
