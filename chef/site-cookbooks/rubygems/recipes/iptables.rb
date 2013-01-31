#
# Cookbook Name:: rubygems
# Recipe:: iptables
#

# specifically ordered
rules = %w[
  default_policy drop_garbage inbound_established outbound
  http ssh loopback icmp log_denied reject
]

rules.each_with_index do |rule, index|
  iptables_rule "#{index.to_s.rjust(2, "0")}-#{rule}" do
    source "iptables-#{rule}.erb"
  end
end
