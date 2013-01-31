maintainer       "Phil Cohen"
maintainer_email "github@phlippers.net"
license          "All rights reserved"
description      "RubyGems-specific recipes"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "0.1.0"

recipe "rubygems", "Default recipes for application deployment nodes"
recipe "rubygems::users", "User setup and configuration"

depends "user"
depends "application"
depends "application_ruby"
