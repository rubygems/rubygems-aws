#
# Cookbook Name:: rubygems
# Recipe:: stat-update.rb
#

package_name = "stat-update_1.0.0-1_amd64.deb"

cookbook_file "#{Chef::Config[:file_cache_path]}/#{package_name}"

dpkg_package "#{Chef::Config[:file_cache_path]}/#{package_name}"
