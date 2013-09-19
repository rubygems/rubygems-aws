template "/etc/cloud/cloud.cfg" do
  source "cloudinit.cfg.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end
