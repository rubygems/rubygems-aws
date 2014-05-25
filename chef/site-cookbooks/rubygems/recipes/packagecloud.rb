# install the "extras" repo

execute "add extras repo for the rubygems account on packagecloud" do
  command "curl https://packagecloud.io/install/repositories/rubygems/extras/script.deb | sudo bash"
  not_if { ::File.exist?("/etc/apt/sources.list.d/rubygems_extras.list") }
end