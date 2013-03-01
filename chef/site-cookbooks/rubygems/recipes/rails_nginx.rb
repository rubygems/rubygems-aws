app_env = "#{node["application"]["name"]}-#{node["application"]["rails_env"]}"

template "#{node["nginx"]["dir"]}/sites-available/#{app_env}.conf" do
  source "nginx_application.conf.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  action :create
  variables(
    name:       node["application"]["name"],
    rails_env:  node["application"]["rails_env"],
    rails_root: node["application"]["rails_root"],
    app_server: node["application"]["app_server"],
    log_dir:    node["nginx"]["log_dir"]
  )
  notifies :reload, "service[nginx]", :immediately
end

# symlink to sites-enabled
link "#{node["nginx"]["dir"]}/sites-enabled/#{app_env}.conf" do
  to "#{node["nginx"]["dir"]}/sites-available/#{app_env}.conf"
  notifies :reload, "service[nginx]", :immediately
end

# logrotate for nginx
logrotate_app "nginx" do
  cookbook "logrotate"
  path "#{node["nginx"]["log_dir"]}/*.log"
  frequency "daily"
  rotate 2
  options ["missingok", "compress", "delaycompress", "notifempty", "sharedscripts"]
  postrotate "[ -f #{node["nginx"]["pid_file"]} ] && kill -USR1 `cat #{node["nginx"]["pid_file"]}`"
  create "640 nginx adm"
end
