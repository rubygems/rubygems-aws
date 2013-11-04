device_id = '/dev/xvdf'
mount_point = '/var/lib/pg_data'

if node['cloud'] && node['cloud']['provider'] == 'ec2'

  creds = data_bag_item('secrets', 'aws')
  include_recipe 'aws'

  aws_ebs_volume 'pg_data_volume' do
    aws_access_key creds['aws_access_key_id']
    aws_secret_access_key creds['aws_secret_access_key']
    size 100
    volume_type 'io1'
    piops 1000
    device device_id.gsub('xvd', 'sd')
    action [:create, :attach]
  end

  ruby_block "wait_for_pg_data_volume" do
    block do
      loop do
        if File.blockdev?(device_id)
          break
        else
          Chef::Log.info("device #{device_id} not ready - sleeping 10s")
          sleep 10
        end
      end
    end
  end

  execute 'mkfs' do
    command "mkfs -t xfs #{device_id}"
    not_if "cat /proc/mounts | grep -qs '#{mount_point}'"
  end

  mount mount_point do
    device device_id
    fstype 'xfs'
    action [:enable, :mount]
  end

  # TODO: redis data volume

end
