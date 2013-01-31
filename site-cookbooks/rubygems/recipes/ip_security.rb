#
# Cookbook Name:: rubygems
# Recipe:: ip_security
#

bash "disable tcp timestamps" do
  code   "echo 0 > /proc/sys/net/ipv4/tcp_timestamps"
  not_if "cat /proc/sys/net/ipv4/tcp_timestamps | grep 0"
end

bash "enable syn cookies (prevent against the common 'syn flood attack')" do
  code   "echo 1 > /proc/sys/net/ipv4/tcp_syncookies"
  not_if "cat /proc/sys/net/ipv4/tcp_syncookies | grep 1"
end

bash "disable Packet forwarning between interfaces" do
  code   "echo 0 > /proc/sys/net/ipv4/ip_forward"
  not_if "cat /proc/sys/net/ipv4/ip_forward | grep 0"
end

bash "ignore all ICMP ECHO and TIMESTAMP requests sent to it via broadcast/multicast" do
  code   "echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts"
  not_if "cat /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts | grep 1"
end

bash "log packets with impossible addresses to kernel log" do
  code   "echo 1 > /proc/sys/net/ipv4/conf/all/log_martians"
  not_if "cat /proc/sys/net/ipv4/conf/all/log_martians | grep 1"
end

bash "disable logging of bogus responses to broadcast frames" do
  code   "echo 1 > /proc/sys/net/ipv4/icmp_ignore_bogus_error_responses"
  not_if "cat /proc/sys/net/ipv4/icmp_ignore_bogus_error_responses | grep 1"
end

bash "do source validation by reversed path (Recommended option for single homed hosts)" do
  code   "echo 1 > /proc/sys/net/ipv4/conf/all/rp_filter"
  not_if "cat /proc/sys/net/ipv4/conf/all/rp_filter | grep 1"
end

bash "don't send redirects" do
  code   "echo 0 > /proc/sys/net/ipv4/conf/all/send_redirects"
  not_if "cat /proc/sys/net/ipv4/conf/all/send_redirects | grep 0"
end

bash "don't accept packets with SRR option" do
  code   "echo 0 > /proc/sys/net/ipv4/conf/all/accept_source_route"
  not_if "cat /proc/sys/net/ipv4/conf/all/accept_source_route | grep 0"
end
