knife[:provisioning_path] = '/var/cache/chef'

cookbook_path   ['chef/cookbooks', 'chef/site-cookbooks']
role_path       'chef/roles'
data_bag_path   'chef/data_bags'
