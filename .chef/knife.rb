current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                ENV['RUBYGEMS_CHEF_USERNAME']
client_key               "#{current_dir}/#{ENV['RUBYGEMS_CHEF_USERNAME']}.pem"
validation_client_name   "rubygems-validator"
validation_key           "#{current_dir}/rubygems-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/rubygems"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
