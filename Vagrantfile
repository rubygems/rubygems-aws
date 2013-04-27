# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  if !File.directory?(File.expand_path("../chef/cookbooks", __FILE__))
    puts "Run `librarian-chef install` first to bring down the cookbooks."
    exit 1
  end

  config.vm.define :app do |app|
    app.vm.host_name = "rubygems-org-app"
    app.vm.box = "opscode-ubuntu-12.04"
    app.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-10.18.2.box"

    # Use more RAM to assist with setting up lots of infra
    app.vm.customize ["modifyvm", :id, "--memory", "768"]

    app.vm.network :hostonly, "33.33.33.10"
  end

  config.vm.define :balancer do |balancer|
    balancer.vm.host_name = "rubygems-org-balancer"
    balancer.vm.box = "opscode-ubuntu-12.04"
    balancer.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-10.18.2.box"

    # Use more RAM to assist with setting up lots of infra
    balancer.vm.customize ["modifyvm", :id, "--memory", "768"]

    balancer.vm.network :hostonly, "33.33.33.11"
  end

  config.vm.define :dbmaster do |dbmaster|
    dbmaster.vm.host_name = "rubygems-org-dbmaster"
    dbmaster.vm.box = "opscode-ubuntu-12.04"
    dbmaster.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-10.18.2.box"

    # Use more RAM to assist with setting up lots of infra
    dbmaster.vm.customize ["modifyvm", :id, "--memory", "768"]

    dbmaster.vm.network :hostonly, "33.33.33.12"
  end

  config.vm.define :search do |search|
    search.vm.host_name = "rubygems-org-search"
    search.vm.box = "opscode-ubuntu-12.04"
    search.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-10.18.2.box"

    # Use more RAM to assist with setting up lots of infra
    search.vm.customize ["modifyvm", :id, "--memory", "768"]

    search.vm.network :hostonly, "33.33.33.13"
  end

end
