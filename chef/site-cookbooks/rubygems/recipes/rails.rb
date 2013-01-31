#
# Cookbook Name:: rubygems
# Recipe:: rails
#

rails_root        = node["application"]["rails_root"]
rails_env         = node["application"]["rails_env"]
app_env           = "#{node["application"]["name"]}-#{node["application"]["rails_env"]}"
sudo_name         = app_env.tr("-", "_").upcase
bundle_cmd        = "bundle"
company_name      = node["application"]["company_name"]
first_server_name = node["application"]["server_names"][0]

# application directory
directory "/applications" do
  owner  "deploy"
  group  "deploy"
  action :create
end

# application directory
directory "/applications/#{node["application"]["name"]}" do
  owner  "deploy"
  group  "deploy"
  action :create
end

# rails root
directory rails_root do
  owner  "deploy"
  group  "deploy"
  action :create
  recursive true
end

# capistrano setup
%w[shared releases].each do |dir|
  directory "#{rails_root}/#{dir}" do
    owner  "deploy"
    group  "deploy"
    action :create
  end
end

# standard shared locations
shared_dirs = %w[
  assets attachments backup cache config log pids sockets system tmp
]
shared_dirs.each do |dir|
  directory "#{rails_root}/shared/#{dir}" do
    owner  "deploy"
    group  "deploy"
    action :create
    recursive true
  end
end

# logrotate for application
template "/etc/logrotate.d/#{app_env}" do
  source "logrotate-application.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  action :create
  variables(service_name: app_env, rails_root: rails_root)
end
