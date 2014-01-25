name "redis"

run_list(
  "role[base]",
  # "recipe[redis::server]"
)

default_attributes(
  "monit" => {
    "monitors" => ["redis"]
  },
  "redis" => {
    "bind" => "",
    "maxmemory" => "8gb",
    "dir" => "/var/lib/redis_data"
  }
)
