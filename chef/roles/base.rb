name "base"
description "The base role with required system-level recipes for all nodes"
run_list(
  "recipe[rubygems::users]",
  "recipe[apt]",
  "recipe[build-essential]",
  "recipe[rubygems::cloudinit]",
  "recipe[xfs]",
  "role[system_tools]",
  "role[logging]",
  "role[shell]",
  "role[security]",
  "role[monitoring]",
  "role[mailer]"
)

default_attributes(
  "denyhosts" => {
    "admin_email" => "github@phlippers.net",
    "allowed_hosts" => []
  },
  "iptables" => {
    "install_rules" => false
  },
  "logwatch" => {
    "mailto" => "github@phlippers.net"
  },
  "monit" => {
    "monitors" => [
      "cron", "filesystem", "ntp", "postfix"
    ]
  },
  "nginx" => {
    "status_port" => 81
  },
  "ntp" => {
    "is_server" => false,
    "servers" => [
      "0.pool.ntp.org",
      "1.pool.ntp.org",
      "2.pool.ntp.org",
      "3.pool.ntp.org"
    ]
  },
  "openssh" => {
    "server" => {
      "password_authentication" => "no",
      "permit_root_login" => "no",
      "subsystem" => "sftp internal-sftp"
    }
  },
  "postfix" => {
    "aliases" => {
      "root" => "github@phlippers.net"
    }
  },
  "resolver" => {
    "search" => "rubygems.org",
    "nameservers" => ["8.8.8.8", "8.8.4.4"]
  }
)
