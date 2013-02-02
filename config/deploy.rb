require "bundler/capistrano"
require 'capistrano/ext/multistage'
set :stages, %w(vagrant rubygems.org)
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

namespace :aws do

  task :connect do
    require 'fog'
    @compute = Fog::Compute.new({:provider => 'AWS', :region => 'us-west-2', :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'], :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']})
  end
  before("aws:boot", "aws:connect")
  before("aws:list", "aws:connect")
  before("aws:destroy", "aws:connect")

  desc "Boot ec2 instances"
  task :boot do
    puts "Launching an instance..."
    server = @compute.servers.create(:image_id => 'ami-ca2ca4fa', :flavor_id => 'm1.small')
    server.wait_for { ready? }
    system "echo '#{server.id} #{server.dns_name}' >> ./instances.list"
    puts "#{server.id} #{server.dns_name}"
    puts "Done!"
  end

  desc "List ec2 instances that were created via cap"
  task :list do
    # puts @compute.servers.inspect
    puts File.read('instances.list')
  end

  desc "Destroy all instances created via cap"
  task :destroy do
    File.read('instances.list').split("\n").each do |instance|
      puts "Destroying instance: #{instance}"
      @compute.servers.get(instance.split(" ")[0]).destroy
      system "grep -v '#{instance}' instances.list > instances.list"
    end
  end

end

namespace :chef do
  desc "Run chef"
  task :default do
    find_and_execute_task("chef:db")
    find_and_execute_task("chef:app")
    find_and_execute_task("chef:lb")
  end

  %w(dbmaster app balancer).each do |role|
    task role, :roles => [role] do
      find_and_execute_task("librarian_chef:install")
      system("tar czf 'chef.tar.gz' -C chef/ .")
      upload("chef.tar.gz","/home/#{user}",:via => :scp)
      sudo("rm -rf /home/#{user}/chef")
      run("mkdir -p /home/#{user}/chef")
      run("tar xzf 'chef.tar.gz' -C /home/#{user}/chef")
      sudo("/bin/bash -c 'cd /home/#{user}/chef && #{chef_binary} -c solo.rb -j nodes/#{role}.#{environment_name}.json'")
      run("rm -rf /home/#{user}/chef.tar.gz")
    end

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
