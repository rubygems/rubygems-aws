name "logging"
description "The role which supports logging-related tasks for nodes"
run_list(
  "recipe[logrotate]",
  "recipe[logwatch]",
  "recipe[rubygems::papertrail]"
)
