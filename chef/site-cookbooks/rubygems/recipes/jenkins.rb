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

template "#{node["nginx"]["dir"]}/sites-available/jenkins.conf" do
  source "nginx_jenkins.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
  variables(
    ssl_key:          File.join(node["nginx"]["dir"], "certs", node["application"]["ssl_key"]),
    ssl_cert:         File.join(node["nginx"]["dir"], "certs", node["application"]["ssl_cert"]),
    upstream_address: "http://jenkins.rubygems.org:8080"
  )
  notifies :reload, "service[nginx]", :immediately
end

file "#{node["nginx"]["dir"]}/sites-enabled/default" do
  action :delete
  notifies :reload, "service[nginx]", :immediately
end

link "#{node["nginx"]["dir"]}/sites-enabled/jenkins.conf" do
  to "#{node["nginx"]["dir"]}/sites-available/jenkins.conf"
  notifies :reload, "service[nginx]", :immediately
end

rbenv_ruby "1.9.3-p448" do
  action :install
end
