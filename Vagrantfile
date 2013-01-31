# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.define :app do |app|
    app.vm.host_name = "rubygems-org-app"
    app.vm.box = "precise64"
    app.vm.box_url = "http://files.vagrantup.com/precise64.box"
    app.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
      chef.roles_path = "roles"
      chef.add_role("rubygems")
    end
  end
end
