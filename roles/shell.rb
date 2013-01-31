name "shell"
description "The role with shell-related recipes for nodes"
run_list(
  "recipe[bash-completion]",
  "recipe[grc]",
  "recipe[screen]",
  "recipe[rvm::system]"
)
