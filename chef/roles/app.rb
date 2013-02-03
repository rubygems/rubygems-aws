name "app"
description "Just enough sauce to run the app server."
run_list(
  "role[base]",
  "recipe[memcached]",
  "recipe[redis::server]",
  "recipe[rubygems::stat-update]",
  "role[rubygems]"
)

default_attributes({"redis" => {
                       "maxmemory" => "8gb",
                       "dir" => "/var/lib/redis_data"}})
