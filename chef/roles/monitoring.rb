name "monitoring"
description "The role with system monitoring recipes for all nodes"
run_list(
  "recipe[htop]",
  "recipe[iftop]",
  "recipe[monit]",
  "recipe[newrelic-sysmond]",
  "recipe[munin]"
)

default_attributes(
  "new_relic" => {
    "license_key" => ""
  }
)
