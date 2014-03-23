chef_username = 'RUBYGEMS_CHEF_USERNAME'
env_username = ENV[chef_username]
raise "You need to set the environment variable #{chef_username} to your hosted chef username" unless env_username

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                chef_username
client_key               "#{current_dir}/#{env_username}.pem"
validation_client_name   "rubygems-validator"
validation_key           "#{current_dir}/rubygems-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/rubygems"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
