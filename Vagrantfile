#!/usr/bin/env ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|

  config.vm.box = 'opscode_ubuntu-12.04_chef-provisionerless'
  config.vm.box_url = 'http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box'

  config.berkshelf.enabled = true

  config.omnibus.chef_version = '11.8.2'

  config.vm.provider 'virtualbox' do |vb|
    vb.customize ['modifyvm', :id, '--memory', '768']
  end

  config.vm.define :app do |app|
    app.vm.host_name = 'rubygems-org-app'
    app.vm.network 'private_network', :ip => '33.33.33.10'
    app.vm.provision 'chef_solo' do |chef|
      chef.roles_path = 'chef/roles'
      chef.data_bags_path = 'chef/data_bags'
      chef.add_role 'app'
      chef.add_role 'vagrant'
      chef.json = {
        "application" => {
          "name" => "rubygems",
          "repository" => "https://github.com/rubygems/rubygems.org.git",
          "rails_env" => "staging",
          "rails_postgresql_host" => "localhost",
          "ssl_key" => "dev.rubygems.org.key",
          "ssl_cert" => "dev.rubygems.org.crt"
        },
        "environment_variables" => {
          "RAILS_ENV" => "staging",
          "RACK_ENV" => "staging",
          "REDIS_URL" => "redis://localhost:6379/0",
          "TMOUT" => "600"
        }
      }
    end
  end

  config.vm.define :balancer do |balancer|
    balancer.vm.host_name = 'rubygems-org-balancer'
    balancer.vm.network 'private_network', :ip => '33.33.33.11'
    balancer.vm.provision 'chef_solo' do |chef|
      chef.roles_path = 'chef/roles'
      chef.data_bags_path = 'chef/data_bags'
      chef.add_role 'balancer'
      chef.add_role 'vagrant'
      chef.json = {
        "application" => {
          "name" => "rubygems",
          "repository" => "https://github.com/rubygems/rubygems.org.git",
          "rails_env" => "staging",
          "rails_root" => "/applications/rubygems/staging",
          "server_names" => ["vagrant.rubygems.org"],
          "use_ssl" => true,
          "force_ssl" => true,
          "ssl_key" => "dev.rubygems.org.key",
          "ssl_cert" => "dev.rubygems.org.crt",
          "app_server" => {
            "name" => "thin",
            "concurrency" => 4
          }
        }
      }
    end
  end

  config.vm.define :dbmaster do |dbmaster|
    dbmaster.vm.host_name = 'rubygems-org-dbmaster'
    dbmaster.vm.network 'private_network', :ip => '33.33.33.12'
    dbmaster.vm.provision 'chef_solo' do |chef|
      chef.roles_path = 'chef/roles'
      chef.data_bags_path = 'chef/data_bags'
      chef.add_role 'db_master'
      chef.add_role 'vagrant'
    end
  end

  config.vm.define :search do |search|
    search.vm.host_name = 'rubygems-org-search'
    search.vm.network 'private_network', :ip => '33.33.33.13'
    search.vm.provision 'chef_solo' do |chef|
      chef.roles_path = 'chef/roles'
      chef.data_bags_path = 'chef/data_bags'
      chef.add_role 'search'
      chef.add_role 'vagrant'
      chef.json = {
        "elasticsearch" => {
          "cluster" => {
            "name" => "rubygems_vagrant"
          },
          "bootstrap" => {
            "mlockall" => false
          }
        }
      }
    end
  end

end
