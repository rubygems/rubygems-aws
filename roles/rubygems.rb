name "clickserve"
description "The role with rails application recipes for ClickServe"
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
  "recipe[rubygems::rails_postgresql]",
  "recipe[rubygems::app_config]"
)
