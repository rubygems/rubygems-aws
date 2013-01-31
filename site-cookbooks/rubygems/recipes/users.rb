#
# Cookbook Name:: rubygems
# Recipe:: users
#

include_recipe "user"

package "libshadow-ruby1.8"
gem_package "ruby-shadow"

node["users"].each do |user|

  user_account user["username"] do
    comment   user["comment"]
    password  user["password"]
    ssh_keys  user["ssh_keys"]
  end

end
