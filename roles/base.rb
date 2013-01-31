name "base"
description "The base role with required system-level recipes for all nodes"
run_list(
  "recipe[rubygems::users]",
  "recipe[apt]",
  "recipe[build-essential]",
  "role[system_tools]",
  "role[logging]",
  "role[shell]",
  "role[security]",
  "role[monitoring]",
  "role[mailer]"
)
