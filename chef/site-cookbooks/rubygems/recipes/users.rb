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
  sysadmins << user['username'] if user['admin']
  user_account user["username"] do
    comment   user["comment"]
    password  user["password"]
    ssh_keys  user["ssh_keys"]
  end
end

sysadmins << "vagrant" if node["sudo"] && node["sudo"]["add_vagrant"]

group "sysadmin" do
  gid 2300
  members sysadmins
end
