name "balancer"
description "The role which contains all cookbooks for a load balancer."
run_list(
  "role[base]",
  "recipe[rubygems::nginx_source]",
  "recipe[rubygems::balancer]"
)

override_attributes(
  "application" => { "application_servers" => [ "10.249.31.114" ]},
  "nginx" => {
    "geoip" => true,
    "dir" => "/opt/nginx/conf"
  }
)
