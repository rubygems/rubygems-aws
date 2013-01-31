# Rubygems AWS Infrastructure Configuration

Chef cookbook and bootstrap scripts to configure and manage Rubygems.org AWS infrastructure

**Note: This cookbook requires Ruby 1.9.x.**

## Hacking in Vagrant

    $ bundle install
    $ librarian-chef install --path=chef/cookbooks
    $ vagrant up

## Hacking on EC2

    Edit nodes/app.rubygems.org.json
    * Add your username to ["authorization"]["sudo"]["users"]
    * Add your user to the "users" hash
      {
        "username": "ruby",
        "comment":  "Rubygems AWS",
        "password": "generated_password",
        "ssh_keys": [
          "your ssh key"
        ]
      }
      You can generate an encrypted password using 'mkpasswd -m sha-512'
    * Add a newrelic license to ["new\_relic"]["license\_key"]
      Alternately remove "recipe[newrelic-sysmond]" from roles/monitoring.rb
    
    $ bundle install
    $ librarian-chef install --path=chef/cookbooks
    $ ec2-run-instances ami-b89842d1
    # Get hostname from ec2-describe-instances
    $ knife solo prepare ubuntu@ec2-*.amazonaws.com
    $ knife solo cook ubuntu@ec2-*.amazonaws.com chef/nodes/app.rubygems.org.json
      
## AMI's

All AMI's use instance root storage and are 64 bit.

* "ap-northeast-1": "ami-70a91271"
* "ap-southeast-1": "ami-15226047"
* "eu-west-1": "ami-3a0f034e"
* "sa-east-1": "ami-6beb3376"
* "us-east-1": "ami-d726abbe"
* "us-west-1": "ami-827252c7"
* "ap-southeast-2": "ami-7f7ee945"
* "us-west-2": "ami-ca2ca4fa"


## Knife bootstrap template

There's a bootstrap template for knife bootstrap or knife ec2 (which
leverages bootstrap). It is WIP.

Use it with `-d chef-full-solo` passed to `knife bootstrap` or
`knife ec2 server create`.

## Private keys

Any private keys you see in this repo are "trash keys" that are not used in production, they are for *testing only*.
