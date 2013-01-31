#
# Cookbook Name:: rubygems
# Recipe:: rvm
#

include_recipe "rvm"

# setup ruby
rvm_ruby node["rvm"]["default_ruby"]

# setup application gemset
rvm_gemset node["application"]["name"] do
  ruby_string node["rvm"]["default_ruby"]
end

# .gemrc defaults
node["users"].each do |user|
  cookbook_file "/home/#{user["username"]}/.gemrc" do
    source "gemrc"
    owner  user["username"]
    group  user["username"]
    mode   "0644"
  end
end
