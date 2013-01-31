#
# Cookbook Name:: rubygems
# Recipe:: users
#

include_recipe "user"

# Omnibus packages include ruby-shadow
users = data_bag("users")
sysadmins = []
users.each do |user_name|
  user = data_bag_item("users", user_name)
  if user['admin']
    sysadmins << user['username']
  end
  user_account user["username"] do
    comment   user["comment"]
    password  user["password"]
    ssh_keys  user["ssh_keys"]
  end
end

if node["sudo"]["add_vagrant"]
  sysadmins << "vagrant"
end

group "sysadmin" do
  gid 2300
  members sysadmins
end
