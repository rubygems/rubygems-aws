name "rubygems_db_master"
description "The role for the primary database server for the RubyGems.org app"

run_list(
  "role[base]",
  "recipe[postgresql::server]"
)

default_attributes(
  "postgresql" => {
    "version" => "9.2",
    "ssl" => false,
    "pg_hba" => [
      "host rubygems_production rubygems 127.0.0.1/32 password"
    ]
  }
)
