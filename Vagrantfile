# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  if !File.directory?(File.expand_path("../cookbooks", __FILE__))
    puts "Run `librarian-chef install` first to bring down the cookbooks."
    exit 1
  end

  config.vm.define :app do |app|
    app.vm.host_name = "rubygems-org-app"
    app.vm.box = "opscode-ubuntu-12.04"
    app.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-10.18.2.box"
    app.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
      chef.roles_path = "roles"
      chef.add_role("rubygems")
      chef.json = JSON.parse(IO.read('nodes/app.rubygems.org.json'))
    end

    # Use more RAM to assist with setting up lots of infra
    app.vm.customize ["modifyvm", :id, "--memory", "768"]
  end
end
