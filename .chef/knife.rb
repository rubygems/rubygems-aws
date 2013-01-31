log_level     :info
log_location  STDOUT
node_name     ENV["NODE_NAME"] || "solo"
client_key    File.expand_path("../solo.pem", __FILE__)
cache_type    "BasicFile"
cache_options(path: File.expand_path("../checksums", __FILE__))
cookbook_path [ File.expand_path("../../chef/cookbooks", __FILE__) ]
# Allow users to add or override knife locally
if ::File.exist?(File.expand_path("../knife.local.rb", __FILE__))
  Chef::Config.from_file(File.expand_path("../knife.local.rb", __FILE__))
end
