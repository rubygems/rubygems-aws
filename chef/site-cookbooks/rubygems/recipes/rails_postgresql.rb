#
# Cookbook Name:: rubygems
# Recipe:: rails_postgresql
#

require "digest/md5"

app_name                  = node["application"]["name"]
rails_env                 = node["application"]["rails_env"]
rails_root                = node["application"]["rails_root"]
app_env                   = "#{app_name}-#{rails_env}"
db_name                   = app_env.tr("-", "_")
rails_postgresql_user     = app_name
rails_postgresql_password = Digest::MD5.hexdigest(app_env.reverse).reverse.tr("A-Za-z", "N-ZA-Mn-za-m")

# create a user
pg_user rails_postgresql_user do
  privileges superuser: false, createdb: false, login: true
  password rails_postgresql_password
end

# create a database
pg_database db_name do
  owner rails_postgresql_user
  encoding "utf8"
  template "template0"
  locale "en_US.UTF8"
end

template "#{rails_root}/shared/config/database.yml" do
  source "database.yml.erb"
  owner  "deploy"
  group  "deploy"
  mode   "0644"
  action :create
  variables(
    adapter:       "postgresql",
    environment:   rails_env,
    username:      rails_postgresql_user,
    password:      rails_postgresql_password,
    database_name: db_name,
    host:          "localhost",
    pool:          30,
    min_messages:  "error"
  )
end
