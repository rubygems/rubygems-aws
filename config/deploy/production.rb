server 'ec2-54-245-134-70.us-west-2.compute.amazonaws.com', :app
server 'ec2-54-245-133-190.us-west-2.compute.amazonaws.com', :dbmaster
# server '', :search
server 'rubygems.org', :balancer
# server 'jenkins.rubygems.org', :jenkins

abort('Must have DEPLOY_USER environment variable') unless ENV['DEPLOY_USER']
set :user, ENV['DEPLOY_USER']
abort('Must have DEPLOY_SSH_KEY environment variable') unless ENV['DEPLOY_SSH_KEY']
set :id_file, ENV['DEPLOY_SSH_KEY']
ssh_options[:keys] = [id_file]
