knife[:provisioning_path] = '/var/cache/chef'

cookbook_path             ['cookbooks', 'site-cookbooks']
data_bag_path             'data_bags'
encrypted_data_bag_secret 'data_bag_key'
node_name                 ENV["NODE_NAME"] || "solo"
role_path                 'roles'
