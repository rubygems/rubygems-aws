name "app"
description "Just enough sauce to run the app server."
run_list(
  "role[base]",
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
  "monit" => {
    "monitors" => ["nginx"]
  }
)
