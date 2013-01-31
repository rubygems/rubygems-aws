name "rubygems"
description "The role with rails application recipes for rubygems"
run_list(
  "recipe[git]",
  "recipe[nginx::server]",
  "recipe[nodejs]",
  "recipe[postgresql::libpq]",
  "recipe[rubygems::environment_variables]",
  "recipe[rubygems::monit]",
  "recipe[rubygems::rails]",
  "recipe[rubygems::rails_nginx]"
)
default_attributes({"application" => { "server_pool" => [ "127.0.0.1" ],
                       "listen_port" => 3000
                     }})
