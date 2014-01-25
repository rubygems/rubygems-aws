#
# Cookbook Name:: nginx
# Recipe:: nginx_source
#

node.set['nginx']['version'] = '1.5.8'
node.set['nginx']['iteration'] = '1'

include_recipe 'nginx::ohai_plugin'

package_name = "nginx_#{node['nginx']['version']}-#{node['nginx']['iteration']}_amd64.deb"

cookbook_file "#{Chef::Config[:file_cache_path]}/#{package_name}"

dpkg_package "#{Chef::Config[:file_cache_path]}/#{package_name}"

service 'nginx' do
  supports :status => true, :restart => true, :reload => true
  action   :enable
end

include_recipe 'nginx::commons'
