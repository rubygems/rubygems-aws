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

secrets = data_bag_item("secrets", "rubygems")
rubygems_settings = secrets["application"][node["application"]["rails_env"]]
rails_postgresql_user     = rubygems_settings["rails_postgresql_user"]
rails_postgresql_password = rubygems_settings["rails_postgresql_password"]
rails_postgresql_host = rubygems_settings["rails_postgresql_host"]
rails_postgresql_db = rubygems_settings["rails_postgresql_db"]

s3_key = rubygems_settings["s3_key"]
s3_secret = rubygems_settings["s3_secret"]
secret_token = rubygems_settings["secret_token"]
bundler_token = rubygems_settings["bundler_token"]
bundler_api_url = rubygems_settings["bundler_api_url"]

new_relic_license_key = rubygems_settings["new_relic_license_key"]
new_relic_app_name = rubygems_settings["new_relic_app_name"]

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
# pg_user rails_postgresql_user do
#   privileges superuser: false, createdb: false, login: true
#   password rails_postgresql_password
# end
# 
# # create a database
# pg_database rails_postgresql_db do
#   owner rails_postgresql_user
#   encoding "utf8"
#   template "template0"
#   locale "en_US.UTF8"
# end

application "rubygems" do
  path node["application"]["rails_root"]
  repository node["application"]["repository"]
  revision node["application"]["revision"]
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
  notifies :restart, "service[rg_delayed_job]"
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

# logrotate for application
template "#{node["application"]["rails_root"]}/current/config/secret.rb" do
  source "secret.rb.erb"
  owner  "deploy"
  group  "deploy"
  mode   "0600"
  action :create
  variables(s3_key: s3_key, s3_secret: s3_secret, secret_token: secret_token, bundler_token: bundler_token, bundler_api_url: bundler_api_url, new_relic_license_key: new_relic_license_key, new_relic_app_name: new_relic_app_name)
end

# Simplest thing that works: setup the worker; logs will be in the
# rails_root/shared/log/rg_delayed_job
directory "#{node['application']['rails_root']}/shared/log/rg_delayed_job" do
  recursive true
end

runit_service "rg_delayed_job" do
  options node['application']
  vars = (node['application']['environment_variables'] || {})
  vars['RAILS_ENV'] ||= "production"
  env vars
end
