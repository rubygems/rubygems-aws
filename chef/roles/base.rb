name "base"
description "The base role with required system-level recipes for all nodes"
run_list(
  "recipe[rubygems::users]",
  "recipe[apt]",
  "recipe[build-essential]",
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
      "cron", "filesystem", "ntp", "postfix", "postgresql", "redis", "nginx", "memcached"
    ]
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
    "search" => "rubygem.org",
    "nameservers" => ["8.8.8.8", "8.8.4.4"]
  },
  "users" => [
    {
      "username" => "phlipper",
      "comment" =>  "Phil Cohen",
      "password" => "$1$1pcXt/Tf$BiibTQY9dcYvlKlYuFp5r0",
      "ssh_keys" => [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBXB0EwpWiZWrshvzFmTKs/L6FjMuJ9WnSfoeBDoCuZjgOnEeq2E8948s2q1BE2VU9VwlCVOPrpv4Nf3qzXG52k6LUHkgq1DIpKjXJenmz95HxfqHAlNIWXSX90ywPiJZr42CM+SFxtmITj81rpn9o8YxUCnxqD4Zww/2tkDI3vCzIad8EDZ6FKV4J8psV1rCVHcGCzm5T5xdNXSCcg7tc2XvDvdj7aJ+cCulCbBkMGTNoytF8nIfzI5xfVLjm3TIPfGDlF+NXC8oEiENJq5WdRuPEPaNF2ks2MJlhDE2oY33dN0YU6e2Saeo9L2fRpZUrpR9zLejEFw6O+ePC8Ont temp@rubygems.phlippers.net"
      ]
    },
    {
      "username" => "samkottler",
      "comment" => "Sam Kottler",
      "password" => "$1$0rHKd1au$qNQ/3uZ1ATDDnrG9JMLG3.",
      "ssh_keys" => [
        "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAuZUm6qBJDRKWzrZGx3hiWlVUtmyWvlQGbmI/GyMGqTzzABIb3n8RjpCEBwiBu01wu6ECfyPJ2qGW87G+DVpb1Z5orxQWRPruEg3aw5lXxiHA6dAmd6qWVZKBbQYhXheeepD7QrNwWc/MpVzjqeNitLD0TEI56AJTjL5dIFZHYh5ZHYPYoSVIvH53aub3+vGbzaD/eQamYxuBvecb5A2uHwld//KVA77mKFK68gX92ESd77fpcjwY6cEKQpoobBD4mHpXYfxn8+1OoOkuNo0awkhec9hXQJHRpcIHko+BOGac0d1ZECZIPhAwu7U9KpOCutmJ+YhY1He+++OMXydjxQ== sam.kottler@mbp"
      ]
    },
    {
      "username" => "dwradcliffe",
      "comment" =>  "David Radcliffe",
      "password" => "$1$zUPbs1zR$Etel98kFpz1tsWUZouRAe1",
      "ssh_keys" => [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTMHSrFTZyMCs67A92dLIYdFcU6EvMRadH0yk9k1lcEPwqf6NMaYS0Fjqqo7gNWga+8gIO5mTS14lgcJwrfVJ07RjvqMa2bRHwD6x6+xqL9gSxaXulbvvVCm0r64KQ+8bl4/WR7CKi3O+C1c9BlZ1u2WGM7zvV42fmRcCmFBHV9VVWcHR/z7ZczSAhqUdJr9CcUBtL3Wbx14p+AifhncrZ3leK9UZYz4a7b+80TPOaXPidN//ICfVqrlF9z3BG+5o2nK+UFIyX0yQ/LNYlVb7VIUewijgeChA2gqXp7P3EiUhwxi1n4wHY9qXHSnVPiL59D2JBlwxP7aJGai8QgOkp radcliffe.david@gmail.com"
      ]
    },
    {
      "username" => "deploy",
      "comment" =>  "Application Deployment",
      "password" => "$1$OghAZXA4$agFSQnk5/bJVs8rA8SaSh1",
      "ssh_keys" => [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBXB0EwpWiZWrshvzFmTKs/L6FjMuJ9WnSfoeBDoCuZjgOnEeq2E8948s2q1BE2VU9VwlCVOPrpv4Nf3qzXG52k6LUHkgq1DIpKjXJenmz95HxfqHAlNIWXSX90ywPiJZr42CM+SFxtmITj81rpn9o8YxUCnxqD4Zww/2tkDI3vCzIad8EDZ6FKV4J8psV1rCVHcGCzm5T5xdNXSCcg7tc2XvDvdj7aJ+cCulCbBkMGTNoytF8nIfzI5xfVLjm3TIPfGDlF+NXC8oEiENJq5WdRuPEPaNF2ks2MJlhDE2oY33dN0YU6e2Saeo9L2fRpZUrpR9zLejEFw6O+ePC8Ont temp@rubygems.phlippers.net",
        "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAuZUm6qBJDRKWzrZGx3hiWlVUtmyWvlQGbmI/GyMGqTzzABIb3n8RjpCEBwiBu01wu6ECfyPJ2qGW87G+DVpb1Z5orxQWRPruEg3aw5lXxiHA6dAmd6qWVZKBbQYhXheeepD7QrNwWc/MpVzjqeNitLD0TEI56AJTjL5dIFZHYh5ZHYPYoSVIvH53aub3+vGbzaD/eQamYxuBvecb5A2uHwld//KVA77mKFK68gX92ESd77fpcjwY6cEKQpoobBD4mHpXYfxn8+1OoOkuNo0awkhec9hXQJHRpcIHko+BOGac0d1ZECZIPhAwu7U9KpOCutmJ+YhY1He+++OMXydjxQ== sam.kottler@mbp"
      ]
    }
  ]
)
