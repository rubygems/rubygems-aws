name "system_tools"
description "The role with system-level recipes for all nodes"
run_list(
  "recipe[curl]",
  "recipe[ntp]",
  "recipe[hostname]",
  "recipe[resolver]",
  "recipe[rsync]",
  "recipe[rubygems::system_ruby]",
  "recipe[xml]",
  "recipe[xslt]"
)
