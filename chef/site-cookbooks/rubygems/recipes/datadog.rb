#
# Cookbook Name:: rubygems
# Recipe:: datadog
#

if data_bag("secrets").include?("datadog")

  datadog_secrets = data_bag_item("secrets", "datadog")

  node.set['datadog']['api_key'] = datadog_secrets['api_key']
  node.set['datadog']['application_key'] = datadog_secrets['application_key']

  # Chef handler
  include_recipe "datadog::dd-handler"

  # Memcached integration
  if node['memcached']
    package "python-memcache"
    node.set['datadog']['memcached']['listen'] = node['memcached']['listen']
    node.set['datadog']['memcached']['port'] = node['memcached']['port']
  end

  # Redis integration
  if node['redis']
    package "python-redis"
    node.set['datadog']['redis']['server']['addr'] = node['redis']['bind']
    node.set['redis']['server']['port'] = node['redis']['port']
  end

  # Postgres integration
  # if node['postgres']
  #   package "python-psycopg2"
  #   node.set['datadog']['postgres']['server'] = "localhost"
  #   node.set['datadog']['postgres']['port'] = node['postgresql']['port']
  #   node.set['datadog']['postgres']['user'] = "datadog"
  #   node.set['postgres'['datadog']]['password'] = datadog_secrets['postgres_password']
  # end

  # Nginx integration
  if node['nginx'] && node["nginx"]["enable_stub_status"]
    node.set['datadog']['nginx']['status_url'] = "http://127.0.0.1:#{node['nginx']['status_port']}/nginx_status/"
  end

  # Agent config
  include_recipe "datadog::dd-agent"

end
