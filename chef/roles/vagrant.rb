name "vagrant"
description "The base vagrant role with a few overrides"
 
override_attributes(
  "authorization" => {
    "sudo" => {
      "passwordless" => true
    }
  },
  "sudo" => {
    "add_vagrant" => true
  }
)