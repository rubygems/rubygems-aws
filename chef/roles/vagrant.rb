name "vagrant"
description "The base vagrant role with a few overrides"

run_list(
  "recipe[rubygems::purge_denyhosts]"
)

override_attributes(
  "authorization" => {
    "sudo" => {
      "passwordless" => true
    }
  },
  "denyhosts" => {
    "allowed_hosts" => ["10.0.2.2"]
  },
  "sudo" => {
    "add_vagrant" => true
  },
  "nginx" => {
    "log_dir" => "/var/log/nginx"
  }
)
