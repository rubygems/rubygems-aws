require 'capistrano/ext/multistage'
set :stages, %w(vagrant staging production)
set :default_stage, 'vagrant'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

namespace :bootstrap do
  desc "bootstrap the server for chef"
  task :default, :roles => [:app, :db, :search, :balancer] do
    find_servers_for_task(current_task).each do |current_server|
      system("knife bootstrap -d chef-solo -x #{user} --sudo #{current_server}")
    end
  end
end

namespace :chef do
  desc "Run chef"
  task :default do
    find_and_execute_task("chef:dbmaster")
    find_and_execute_task("chef:search")
    find_and_execute_task("chef:app")
    find_and_execute_task("chef:balancer")
  end

  %w(dbmaster search app balancer jenkins).each do |role|
    task role, :roles => [role] do
      find_servers_for_task(current_task).each do |current_server|
        current_node_name = fetch(:node_name, current_server.to_s.split('.')[0])
        system("knife solo cook #{user}@#{current_server} chef/nodes/#{role}.#{stage}.json -i #{id_file} -N #{current_node_name}")
      end
    end
  end

end
