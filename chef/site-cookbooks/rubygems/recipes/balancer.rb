#
# Cookbook Name:: rubygems
# Recipe:: rails_nginx
#

app_env = "#{node["application"]["name"]}-#{node["application"]["rails_env"]}"

# ssl certificates directory
directory "#{node["nginx"]["dir"]}/certs" do
  owner "root"
  group "root"
  mode  "0644"
  action :create
end

# ssl certificate key
cookbook_file "#{node["nginx"]["dir"]}/certs/#{node["application"]["ssl_key"]}" do
  source node["application"]["ssl_key"]
  owner  "root"
  group  "root"
  mode   "0644"
  notifies :reload, "service[nginx]", :immediately
end

# ssl certificate
cookbook_file "#{node["nginx"]["dir"]}/certs/#{node["application"]["ssl_cert"]}" do
  source node["application"]["ssl_cert"]
  owner  "root"
  group  "root"
  mode   "0644"
  notifies :reload, "service[nginx]", :immediately
end

# vhost configuration
template "#{node["nginx"]["dir"]}/sites-available/#{app_env}-balancer.conf" do
  source "nginx_balancer.conf.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  action :create
  variables(
    name:         node["application"]["name"],
    rails_env:    node["application"]["rails_env"],
    rails_root:   node["application"]["rails_root"],
    app_server:   node["application"]["app_server"],
    server_names: node["application"]["server_names"],
    use_ssl:      node["application"]["use_ssl"],
    force_ssl:    node["application"]["force_ssl"],
    ssl_key:      File.join(node["nginx"]["dir"], "certs", node["application"]["ssl_key"]),
    ssl_cert:     File.join(node["nginx"]["dir"], "certs", node["application"]["ssl_cert"]),
    nginx_dir:    node["nginx"]["dir"]
  )
  notifies :reload, "service[nginx]", :immediately
end

# geoip config
if node["nginx"]["geoip"]
  template "#{node["nginx"]["dir"]}/conf.d/geoip.conf" do
    source "nginx-geoip.conf.erb"
    owner "root"
    group "root"
    mode  "0644"
    notifies :restart, "service[nginx]", :immediately
  end
end

# symlink to sites-enabled
link "#{node["nginx"]["dir"]}/sites-enabled/#{app_env}-balancer.conf" do
  to "#{node["nginx"]["dir"]}/sites-available/#{app_env}-balancer.conf"
  notifies :reload, "service[nginx]", :immediately
end
