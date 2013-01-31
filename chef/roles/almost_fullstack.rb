name "almost_fullstack"
description "The role which contains all cookbooks for a 'full-stack' minus the load balancer server."
run_list(
  "role[base]",
  "recipe[memcached]",
  "recipe[redis::server]",
  "recipe[postgresql::server]",
  "role[rubygems]"
)
