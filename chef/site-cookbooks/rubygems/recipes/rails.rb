#
# Cookbook Name:: rubygems
# Recipe:: rails
#

rails_root        = node["application"]["rails_root"]
rails_env         = node["application"]["rails_env"]
app_env           = "#{node["application"]["name"]}-#{node["application"]["rails_env"]}"
sudo_name         = app_env.tr("-", "_").upcase
bundle_cmd        = "bundle"
company_name      = node["application"]["company_name"]
first_server_name = node["application"]["server_names"][0]

secrets = data_bag_item("secrets", "postgresql")
db_settings = secrets["application"][node["application"]["rails_env"]]
rails_postgresql_user     = db_settings["rails_postgresql_user"]
rails_postgresql_password = db_settings["rails_postgresql_password"]
rails_postgresql_host = db_settings["rails_postgresql_host"]
rails_postgresql_db = db_settings["rails_postgresql_db"]

# # application directory
directory "/applications" do
  owner  "deploy"
  group  "deploy"
  action :create
end

# application directory
directory "/applications/#{node["application"]["name"]}" do
  owner  "deploy"
  group  "deploy"
  action :create
end

# create a DB user
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

application "rubygems" do
  path node["application"]["rails_root"]
  repository node["application"]["repository"]
  owner "deploy"
  group "deploy"
  packages %w{libpq-dev}
  migrate true

  r = rails do
    gems %w{bundler}
    bundle_command "/usr/local/bin/bundle"
    database_template "database.yml.erb"
    database do
      adapter "postgresql"
      database rails_postgresql_db
      username rails_postgresql_user
      password rails_postgresql_password
      host rails_postgresql_host
    end
  end
  r.cookbook_name = "rubygems"

  unicorn do
    port "3000"
    bundler true
    bundle_command "/usr/local/bin/bundle"
  end
end

# logrotate for application
template "/etc/logrotate.d/#{app_env}" do
  source "logrotate-application.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  action :create
  variables(service_name: app_env, rails_root: rails_root)
end
