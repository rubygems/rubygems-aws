#
# Cookbook Name:: rubygems
# Recipe:: monit
#

# logrotate for monit
template "/etc/logrotate.d/monit" do
  source "logrotate-monit.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  action :create
end

node["monit"]["monitors"].each do |monitor|
  monit_monitrc monitor
end
