cookbook_path             [
                            File.expand_path("/tmp/chef/cookbooks", __FILE__),
                            File.expand_path("/tmp/chef/site-cookbooks", __FILE__)
                          ]
data_bag_path             File.expand_path("/tmp/chef/data_bags", __FILE__)
encrypted_data_bag_secret File.expand_path("/tmp/chef/data_bag_key", __FILE__)
file_cache_path           File.expand_path("/tmp/chef", __FILE__)
file_backup_path          File.expand_path("/tmp/chef/backup", __FILE__)
node_name                 ENV["NODE_NAME"] || "solo"
role_path                 File.expand_path("/tmp/chef/roles", __FILE__)
