#
# Cookbook Name:: nginx
# Recipe:: nginx_source.rb
#

include_recipe "rubygems::packagecloud"

package "nginx" do
  version "1.5.1"
end

# Continue to use upstream cookbooks
# for basic configuration and service management

template "/etc/init.d/nginx" do
  source "nginx.init.erb"
  owner "root"
  group "root"
  mode 00755
  variables(:src_binary => "/opt/nginx/sbin/nginx", :pid => node['nginx']['pid_file'])
end

directory "/opt/nginx/conf/conf.d"
directory "/var/log/nginx"

include_recipe "nginx::service"
include_recipe "nginx::configuration"
