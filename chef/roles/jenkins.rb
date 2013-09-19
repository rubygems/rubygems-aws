name "jenkins"
description "Jenkins server."
run_list(
  "role[base]",
  "recipe[jenkins]",
  "recipe[git]",
  "recipe[ruby_build]",
  "recipe[rbenv::system_install]",
  "recipe[nginx::server]",
  "recipe[rubygems::jenkins]"
)
