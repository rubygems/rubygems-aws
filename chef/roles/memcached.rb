name 'memcached'
description 'Memcached node for object caching.'
run_list(
  "role[base]",
  "recipe[memcached]"
)

# TODO: memcached will need to listen on eth0 instead of localhost.
default_attributes(
  "memcached" => {
    "memory" => 128,
    "user" => "memcache",
    "port" => 11211,
    "listen" => "127.0.0.1"
  },
  "monit" => {
    "monitors" => ["memcached"]
  }
)
