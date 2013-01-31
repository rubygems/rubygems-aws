#
# Cookbook Name:: rubygems
# Recipe:: environment_variables
#

# chef can't deal with an empty file
bash "ensure /etc/environment has content" do
  code %(echo "# touched at `date`" > /etc/environment)
  only_if { File.stat("/etc/environment").size.zero? }
end

ruby_block "setup system ENVIRONMENT variables" do
  block do
    require "chef/util/file_edit"
    file = Chef::Util::FileEdit.new "/etc/environment"

    node["environment_variables"].each do |k, v|
      match = /#{k}/
      kv    = "#{k}=#{v}"

      file.search_file_replace_line(match, kv) # update existing
      file.insert_line_if_no_match(match, kv ) # add new
      file.write_file
    end
  end
end
