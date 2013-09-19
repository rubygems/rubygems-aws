name "jenkins"
description "Jenkins server."
run_list(
  "role[base]",
  "recipe[jenkins]"
)
