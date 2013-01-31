name "monitoring"
description "The role with system monitoring recipes for all nodes"
run_list(
  "recipe[htop]",
  "recipe[iftop]",
  "recipe[monit]",
  "recipe[munin]",
  "recipe[newrelic-sysmond]"
)
