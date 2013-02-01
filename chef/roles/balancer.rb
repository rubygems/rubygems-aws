name "balancer"
description "The role which contains all cookbooks for a load balancer."
run_list(
  "role[base]",
  "recipe[nginx::server]",
  "recipe[rubygems::balancer]"
)

override_attributes(
  "application" => { "application_servers" => [ "10.249.31.114" ]},
  "nginx" => {
    "geoip" => false
  }
)
