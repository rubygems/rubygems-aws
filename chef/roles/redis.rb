name 'redis'
description 'Redis node for storing gem download information.'
run_list(
  "role[base]",
  "recipe[redis::server]"
)

default_attributes(
  "redis" => {
    "maxmemory" => "8gb",
    "dir" => "/var/lib/redis_data"
  },
  "monit" => {
    "monitors" => ["redis"]
  }
)
