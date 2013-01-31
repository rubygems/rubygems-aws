name "mailer"
description "Recipes for nodes that send email"
run_list(
  "recipe[postfix]",
  "recipe[postfix::aliases]"
)
