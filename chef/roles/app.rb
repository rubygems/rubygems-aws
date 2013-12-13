name "app"
description "Just enough sauce to run the app server."
run_list(
  "role[base]",
  "recipe[memcached]",
  "recipe[redis::server]",
  "recipe[rubygems::stat-update]",
  "recipe[git]",
  "recipe[nginx::server]",
  "recipe[nodejs]",
  "recipe[postgresql::libpq]",
  "recipe[rubygems::environment_variables]",
  "recipe[rubygems::monit]",
  "recipe[rubygems::rails]",
  "recipe[rubygems::rails_nginx]"
)

default_attributes(
  "memcached" => {
    "memory" => 128,
    "user" => "memcache",
    "port" => 11211,
    "listen" => "127.0.0.1"
  },
  "monit" => {
    "monitors" => ["redis", "nginx", "memcached"]
  },
  "redis" => {
    "maxmemory" => "8gb",
    "dir" => "/var/lib/redis_data"
  }
)
