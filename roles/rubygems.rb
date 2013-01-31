name "rubygems"
description "The role with rails application recipes for rubygems"
run_list(
  "recipe[git]",
  "recipe[nginx::server]",
  "recipe[nodejs]",
  "recipe[postgresql::libpq]",
  "recipe[rubygems::environment_variables]",
  "recipe[rubygems::monit]",
  "recipe[rubygems::rvm]",
  "recipe[rubygems::rails]",
  "recipe[rubygems::rails_nginx]",
  "recipe[rubygems::rails_postgresql]"
)
