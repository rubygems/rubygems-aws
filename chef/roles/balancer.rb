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
  "monit" => {
    "monitors" => ["nginx"]
  },
  "nginx" => {
    "geoip" => true,
    "dir" => "/opt/nginx/conf",
    "log_dir" => "/mnt/log/nginx",
    "worker_processes" => 8,
    "buffers_enable" => true,
    "client_max_body_size" => 0,
    "client_header_timeout" => 60,
    "client_body_timeout" => 60,
    "send_timeout" => 60,
  }
)
