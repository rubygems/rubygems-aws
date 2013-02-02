name "rubygems_db_master"
description "The role for the primary database server for the RubyGems.org app"

run_list(
  "role[base]",
  "recipe[postgresql::server]"
)

default_attributes(
  "postgresql" => {
    "version" => "9.2",
    "data_directory" => "/var/lib/pg_data",
    "listen_addresses" => "10.249.66.172",
    "ssl" => false,
    "work_mem" => "100MB",
    "shared_buffers" => "24MB",
    "pg_hba" => [
      {
        "type" => "host",
        "db" => "gemcutter_production",
        "user" => "postgres",
        "addr" => "10.249.31.114/0",
        "method" => "md5"
      }
    ]
  }
)
