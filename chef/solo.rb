root = File.absolute_path(File.dirname(__FILE__))

cookbook_path             [
                            root + '/cookbooks',
                            root + "/site-cookbooks"
                          ]
data_bag_path             root + "/data_bags"
encrypted_data_bag_secret root + "/data_bag_key"
file_cache_path           root
file_backup_path          root + "/backup"
node_name                 ENV["NODE_NAME"] || "solo"
role_path                 root + "/roles"
