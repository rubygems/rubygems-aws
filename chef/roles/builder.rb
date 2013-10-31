name "builder"
description "Builder setup for debuild with pbuilder and FPM"
run_list(
  "role[base]",
  "recipe[pbuilder]",
  "recipe[rubygems::pbuilder]"
)
