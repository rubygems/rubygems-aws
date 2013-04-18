#
# Cookbook Name:: rubygems
# Recipe:: backups
#

node.set["rubygems"]["backups"]["aws_access_key"] = data_bag_item("secrets", "backups")["aws_access_key"]
node.set["rubygems"]["backups"]["aws_secret_key"] = data_bag_item("secrets", "backups")["aws_secret_key"]
node.set["rubygems"]["backups"]["gpg_key"] = data_bag_item("secrets", "backups")["gpg_key"]

if node['redis']

  ['backup', 's3sync', 'fog', 'mail'].each do |gem_name|
    gem_package gem_name do
      action :install
    end
  end

  directory node["rubygems"]["backups"]["config_dir"] do
    owner "root"
    group "root"
    mode 00755
    action :create
  end

  template File.join(["rubygems"]["backups"]["config_dir"], "redis.rb") do
    source "redis_backup.rb.erb"
    owner "root"
    group "root"
    mode 00644
  end

  cron "redis-backup" do
    hour "23"
    minute "23"
    day "*"
    month "*"
    weekday "*"
    command "backup perform --trigger redis --config-file #{File.join(["rubygems"]["backups"]["config_dir"], "redis.rb")}"
    user "root"
    # path "/bin:/usr/bin"
    # home "/tmp"
    # shell "/bin/bash"
  end

end

if node['postgresql']

  ['backup', 's3sync', 'fog', 'mail'].each do |gem_name|
    gem_package gem_name do
      action :install
    end
  end

  directory node["rubygems"]["backups"]["config_dir"] do
    owner "root"
    group "root"
    mode 00755
    action :create
  end

  secrets = data_bag_item("secrets", "rubygems")
  rubygems_settings = secrets["application"][node["application"]["rails_env"]]

  template File.join(node["rubygems"]["backups"]["config_dir"], "postgresql.rb") do
    source "postgresql_backup.rb.erb"
    owner "root"
    group "root"
    mode 00644
    variables(:settings => rubygems_settings)
  end

  cron "postgresql-backup" do
    hour "22"
    minute "22"
    day "*"
    month "*"
    weekday "*"
    command "backup perform --trigger postgresql --config-file #{File.join(node["rubygems"]["backups"]["config_dir"], "postgresql.rb")}"
    user "root"
    # path "/bin:/usr/bin"
    # home "/tmp"
    # shell "/bin/bash"
  end

end
