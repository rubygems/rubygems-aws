name "jenkins"
description "Jenkins server."
run_list(
  "role[base]",
  "recipe[jenkins]",
  "recipe[nginx::server]",
  "recipe[rubygems::jenkins]"
)
