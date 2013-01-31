# Rubygems AWS Infrastructure Configuration

Chef cookbooks and bootstrap scripts to configure and manage Rubygems.org AWS infrastructure

**Note: This repository requires Ruby 1.9.x.**

## Hacking in Vagrant

    $ bundle install
    $ librarian-chef install
    $ vagrant up
    $ cap chef

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
    $ librarian-chef install
    $ cap aws:boot
    # Get hostname(s) from instances.list
    $ export RUBYGEMS_EC2_APP=ec2-*.amazonaws.com
    $ export RUBYGEMS_EC2_LB1=ec2-*.amazonaws.com
    $ export RUBYGEMS_EC2_DB1=ec2-*.amazonaws.com
    $ cap ec2 bootstrap
    $ cap ec2 chef

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

## Knife configuration

If you wish to modify the knife configuration, e.g. AWS options for
`knife ec2` or Chef Server URL/keys, put them in
`.chef/knife.local.rb` and it will be loaded automatically.

    # Chef Server example
    node_name                "your-user-name"
    client_key               "/Users/your-user-name/.chef/your-usern-name.pem"
    validation_client_name   "your-organization-name-validator"
    validation_key           "/Users/jtimberman/.chef/your-organization-name-validator.pem"
    chef_server_url          "https://api.opscode.com/organizations/your-organization-name"
    # EC2 example (add the env variables)
    knife[:aws_access_key_id]      = ENV['AWS_ACCESS_KEY_ID']
    knife[:aws_secret_access_key]  = ENV['AWS_SECRET_ACCESS_KEY']

## Private keys

Any private keys you see in this repo are "trash keys" that are not used in production, they are for *testing only*.
