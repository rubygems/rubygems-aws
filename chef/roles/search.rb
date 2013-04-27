name "search"
description "The role for the search service for the RubyGems.org app"

run_list(
  "role[base]",
  "recipe[java]",
  "recipe[elasticsearch]",
  "recipe[elasticsearch::plugins]",
  "recipe[elasticsearch::ebs]",
  "recipe[elasticsearch::data]",
  "recipe[elasticsearch::aws]"
)

default_attributes(
  "elasticsearch" => {
    "cluster" => {
      "name" => "rubygems"
    },
    "nginx" => {
      "user"  =>  'www-data',
      "users" => [{ username: '<REPLACE>', password: '<REPLACE>' }],
      "allow_cluster_api" => true
    }
  },
  "authorization" => {
    "sudo" => {
      "passwordless" => true
    }
  }
)
