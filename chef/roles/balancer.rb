name "balancer"
description "The role which contains all cookbooks for a load balancer."
run_list(
  "role[base]",
  "recipe[rubygems::nginx_source]",
  "recipe[rubygems::balancer]"
)

override_attributes(
  "application" => {
    "application_servers" => ["10.249.31.114"],
    "stat_server" => "10.249.31.114:5000"
  },
  "nginx" => {
    "geoip" => true,
    "dir" => "/opt/nginx/conf",
    "worker_processes" => 8,
    "buffers_enable" => true,
    "client_max_body_size" => 0,
  }
)
