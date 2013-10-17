#
# Cookbook Name:: rubygems
# Recipe:: cloudinit
#

directory "/etc/cloud" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

template "/etc/cloud/cloud.cfg" do
  source "cloudinit.cfg.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end
