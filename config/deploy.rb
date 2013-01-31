require "bundler/capistrano"
require 'capistrano/ext/multistage'
set :stages, %w(vagrant vagrant-lb ec2)
set :default_stage, "vagrant"

default_run_options[:pty] = true 
ssh_options[:forward_agent] = true

namespace :bootstrap do
  desc "bootstrap the server for chef"
  task :default, :roles => [:app, :db, :lb] do
    find_servers_for_task(current_task).each do |current_server|
      system("knife bootstrap -d chef-solo -x #{user} --sudo #{current_server}")
    end
  end
end

namespace :librarian_chef do
  desc "install cookbooks"
  task :install do
    system("librarian-chef install")
  end
end

namespace :chef do
  "Run chef"
  task :default do
    find_and_execute_task("chef:app")
    find_and_execute_task("chef:lb")
  end
  
  task :app, :roles => [:app] do
    find_and_execute_task("librarian_chef:install")
    system("tar czf 'chef.tar.gz' -C chef/ .")
    upload("chef.tar.gz","/home/#{user}",:via => :scp)
    sudo("rm -rf /home/#{user}/chef")
    run("mkdir -p /home/#{user}/chef")
    run("tar xzf 'chef.tar.gz' -C /home/#{user}/chef")
    sudo("/bin/bash -c 'cd /home/#{user}/chef && #{chef_binary} -c solo.rb -j nodes/#{node_name}-app.json'")
    run("rm -rf /home/#{user}/chef.tar.gz")
    sudo("rm -rf /home/#{user}/chef")
  end
  
  task :lb, :roles => [:lb] do
    find_and_execute_task("librarian_chef:install")
    system("tar czf 'chef.tar.gz' -C chef/ .")
    upload("chef.tar.gz","/home/#{user}",:via => :scp)
    sudo("rm -rf /home/#{user}/chef")
    run("mkdir -p /home/#{user}/chef")
    run("tar xzf 'chef.tar.gz' -C /home/#{user}/chef")
    sudo("/bin/bash -c 'cd /home/#{user}/chef && #{chef_binary} -c solo.rb -j nodes/#{node_name}-lb.json'")
    run("rm -rf /home/#{user}/chef.tar.gz")
    sudo("rm -rf /home/#{user}/chef")
  end
end

namespace :vg do
  desc "vagrant up"
  task :up do
    system("vagrant up")
  end

  desc "varant destory"
  task :destroy do
    system("vagrant destroy")
  end

  desc "vagrant provision"
  task :provision do
    system("vagrant provision")
  end
end
