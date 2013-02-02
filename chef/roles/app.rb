name "app"
description "Just enough sauce to run the app server."
run_list(
  "role[base]",
  "recipe[memcached]",
  "role[rubygems_redis]",
  "role[rubygems]"
)

default_attributes({"redis" => {
                       "maxmemory" => "8g",
                       "dir" => "/var/lib/redis_data"}})
