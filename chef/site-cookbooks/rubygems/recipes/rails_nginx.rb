#
# Cookbook Name:: rubygems
# Recipe:: rails_nginx
#

node.set['nginx']['server_tokens'] = false
node.set['nginx']['default_site_enabled'] = false

include_recipe 'nginx::default'

template "#{node["nginx"]["dir"]}/sites-available/rubygems.conf" do
  source "nginx_application.conf.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  action :create
  variables(
    rails_env:  node["application"]["rails_env"],
    rails_root: '/applications/rubygems',
    unicorn_port: 3000,
    nginx_port: 2000,
    log_dir:    node["nginx"]["log_dir"]
  )
  notifies :reload, "service[nginx]", :immediately
end

nginx_site 'rubygems.conf'
