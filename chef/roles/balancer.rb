name "balancer"
description "The role which contains all cookbooks for a load balancer."
run_list(
  "role[base]",
  "recipe[nginx]"
)

default_attributes({"application" => { "server_pool" => [ "127.0.0.1" ]}})
