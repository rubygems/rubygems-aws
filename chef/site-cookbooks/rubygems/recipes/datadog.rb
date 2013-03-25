#
# Cookbook Name:: rubygems
# Recipe:: datadog
#

if data_bag("secrets").include?("datadog")

  datadog_secrets = data_bag_item("secrets", "datadog")

  node.set['datadog']['api_key'] = datadog_secrets['api_key']
  node.set['datadog']['application_key'] = datadog_secrets['application_key']

  include_recipe "datadog::dd-agent"
  include_recipe "datadog::dd-handler"

end
