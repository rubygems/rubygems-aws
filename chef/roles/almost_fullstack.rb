name "almost_fullstack"
description "The role which contains all cookbooks for a 'full-stack' minus the load balancer server."

run_list(
  "role[base]",
  "role[rubygems_memcached]",
  "recipe[redis::server]",
  "role[rubygems_db_master]",
  "role[rubygems]"
)
