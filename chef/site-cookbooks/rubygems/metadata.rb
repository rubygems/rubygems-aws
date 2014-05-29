name             'rubygems'
maintainer       'RubyGems.org Ops Team'
license          'MIT'
description      'RubyGems.org specific recipes'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe 'rubygems',                        'Default recipes for all nodes'
recipe 'rubygems::balancer',              'Nginx load balancer config'
recipe 'rubygems::cloudinit',             'Ubuntu cloud config'
recipe 'rubygems::datadog',               'Installs and configures datadog'
recipe 'rubygems::debug-tools',           'Installs common debug packages'
recipe 'rubygems::environment_variables', 'Configure node env variables'
recipe 'rubygems::ip_security',           'System security settings'
recipe 'rubygems::monit',                 'Configure monit logs and monitors'
recipe 'rubygems::nginx_source',          'Installs nginx from our pre-build package'
recipe 'rubygems::papertrail',            'Configures rsyslog to send logs to Papertrail'
recipe 'rubygems::purge_denyhosts',       'Purges all blocked hosts'
recipe 'rubygems::rails',                 'Main app recipe'
recipe 'rubygems::rails_nginx',           'nginx config for app server'
recipe 'rubygems::stat-update',           'Installs stat-update from pre-built package'
recipe 'rubygems::system_ruby',           'Installs ruby'
recipe 'rubygems::users',                 'User setup and configuration'

depends 'user'
depends 'application'
depends 'application_ruby'
depends 'aws'
depends 'logrotate'
depends 'datadog'
depends 'nginx'
depends 'monit'
depends 'runit'
depends 'papertrail-rsyslog'

supports 'ubuntu'
