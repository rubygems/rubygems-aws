name "security"
description "The role with security-related recipes for nodes"
run_list(
  "recipe[openssh]",
  "recipe[sudo]",
  "recipe[denyhosts]",
  "recipe[iptables]",
  "recipe[rubygems::ip_security]",
  "recipe[rubygems::iptables]"
)
