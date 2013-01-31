log_level     :info
log_location  STDOUT
node_name     ENV["NODE_NAME"] || "solo"
client_key    File.expand_path("../solo.pem", __FILE__)
cache_type    "BasicFile"
cache_options(path: File.expand_path("../checksums", __FILE__))
cookbook_path [ File.expand_path("../../cookbooks", __FILE__) ]
