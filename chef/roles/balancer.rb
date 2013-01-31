name "balancer"
description "The role which contains all cookbooks for a load balancer."
run_list(
  "role[base]",
  "recipe[nginx::server]",
  "recipe[rubygems::balancer]"
)

override_attributes({"application" => { "application_servers" => [ "127.0.0.1" ]}})
