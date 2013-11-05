name "rubygems_memcached"
description "Servers running memcached for the RubyGems.org app"

run_list(
  "role[base]",
  "recipe[memcached]"
)

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
