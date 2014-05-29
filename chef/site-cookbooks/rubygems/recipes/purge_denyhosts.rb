#
# Cookbook Name:: rubygems
# Recipe:: purge_denyhosts
#

node.default['denyhosts']['work_dir'] = '/var/lib/denyhosts'

%w(hosts hosts-restricted hosts-root hosts-valid user-hosts).each do |filename|
  file File.join(node['denyhosts']['work_dir'], filename) do
    content ''
    notifies :restart, 'service[denyhosts]'
  end
end

ruby_block "purge /etc/hosts.deny" do
  block do
    file = ::Chef::Util::FileEdit.new('/etc/hosts.deny')
    file.search_file_delete_line(/^[^#|\s]/)
    file.write_file
  end
  only_if { ::File.exists?('/etc/hosts.deny') }
  notifies :restart, 'service[denyhosts]'
end
