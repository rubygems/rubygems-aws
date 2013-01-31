# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.define :app do |app|
    app.vm.host_name = "rubygems-org-app"
    app.vm.box = "opscode-ubuntu-12.04"
    app.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-10.18.2.box"
    app.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
      chef.roles_path = "roles"
      chef.add_role("rubygems")
    end

    # Use more RAM, 1 GB by default
    app.vm.customize ["modifyvm", :id, "--memory", "768"]
  end
end
