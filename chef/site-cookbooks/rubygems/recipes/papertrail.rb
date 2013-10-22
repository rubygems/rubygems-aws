#
# Cookbook Name:: rubygems
# Recipe:: papertrail
#

if data_bag('secrets').include?('papertrail')
  node.set['papertrail']['port'] = data_bag_item('secrets', 'papertrail')['port']
  include_recipe 'papertrail-rsyslog'
else
  Chef::Log.warn("Papertrail data bag missing! Papertrail will not be configured this run.")
end
