name "app"
description "Just enough sauce to run the app server."
run_list(
  "role[base]",
  "recipe[memcached]",
  "role[rubygems_redis]",
  "role[rubygems]"
)
