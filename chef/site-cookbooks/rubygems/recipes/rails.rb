#
# Cookbook Name:: rubygems
# Recipe:: rails
#

rails_root        = '/applications/rubygems'
app_env           = "#{node["application"]["name"]}-#{node["application"]["rails_env"]}"

secrets = data_bag_item("secrets", "rubygems")
rubygems_settings = secrets["application"][node["application"]["rails_env"]]
rails_postgresql_user     = rubygems_settings["rails_postgresql_user"]
rails_postgresql_password = rubygems_settings["rails_postgresql_password"]
rails_postgresql_host = node['application']['rails_postgresql_host']
rails_postgresql_db = rubygems_settings["rails_postgresql_db"]

s3_key = rubygems_settings["s3_key"]
s3_secret = rubygems_settings["s3_secret"]
secret_token = rubygems_settings["secret_token"]
bundler_token = rubygems_settings["bundler_token"]
bundler_api_url = rubygems_settings["bundler_api_url"]

new_relic_license_key = rubygems_settings["new_relic_license_key"]
new_relic_app_name = rubygems_settings["new_relic_app_name"]

directory '/applications' do
  owner  'deploy'
  group  'deploy'
  action :create
end

directory '/applications/rubygems' do
  owner  'deploy'
  group  'deploy'
  mode   '0775'
  action :create
end

directory '/applications/rubygems/releases' do
  owner  'deploy'
  group  'deploy'
  mode   '0775'
  action :create
end

directory '/applications/rubygems/shared' do
  owner  'deploy'
  group  'deploy'
  mode   '0775'
  action :create
end

directory '/applications/rubygems/shared/log' do
  owner  'deploy'
  group  'deploy'
  mode   '0775'
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

package 'libpq-dev'

gem_package 'bundler'

template '/applications/rubygems/shared/database.yml' do
  source 'database.yml.erb'
  owner 'deploy'
  group 'deploy'
  mode '0644'
  variables(
    rails_env: node['application']['rails_env'],
    adapter: 'postgresql',
    database: rails_postgresql_db,
    username: rails_postgresql_user,
    password: rails_postgresql_password,
    host: rails_postgresql_host
  )
end

unicorn_config '/etc/unicorn/rubygems.rb' do
  listen('3000' => {})
  working_directory '/applications/rubygems/current'
  worker_processes [node.fetch('cpu', {}).fetch('total', 1).to_i * 4, 8].min
  before_fork 'sleep 1'
end

include_recipe 'runit'

runit_service 'unicorn' do
  owner 'deploy'
  group 'deploy'
  options(
    name: 'rubygems',
    owner: 'deploy',
    group: 'deploy',
    redis_url: node['environment_variables']['REDIS_URL'],
    bundler: true,
    bundle_command: '/usr/local/bin/bundle',
    rails_env: node['application']['rails_env'],
    smells_like_rack: ::File.exists?('/applications/rubygems/current/config.ru')
  )
  action ::File.exists?('/applications/rubygems/current') ? :enable : :disable
end

# Logrotate for application
template "/etc/logrotate.d/#{app_env}" do
  source "logrotate-application.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  action :create
  variables(service_name: app_env, rails_root: rails_root)
end

# Rails initializer for secret
template '/applications/rubygems/shared/secret.rb' do
  source 'secret.rb.erb'
  owner  'deploy'
  group  'deploy'
  mode   '0640'
  action :create
  variables(
    s3_key: s3_key,
    s3_secret: s3_secret,
    secret_token: secret_token,
    bundler_token: bundler_token,
    bundler_api_url: bundler_api_url,
    new_relic_license_key: new_relic_license_key,
    new_relic_app_name: new_relic_app_name
  )
end

runit_service 'delayed_job' do
  env node['environment_variables']
  action ::File.exists?('/applications/rubygems/current') ? :enable : :disable
end
