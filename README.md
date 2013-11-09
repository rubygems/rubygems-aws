# Rubygems AWS Infrastructure Configuration

[![Build Status](https://travis-ci.org/rubygems/rubygems-aws.png?branch=master)](https://travis-ci.org/rubygems/rubygems-aws)

Chef cookbooks and bootstrap scripts to configure and manage Rubygems.org AWS infrastructure

**Note: This repository requires Ruby 1.9.x.**

## Hacking

    $ bundle install

### Hacking in Vagrant

    $ vagrant up
    $ knife solo cook vagrant@33.33.33.12 chef/nodes/dbmaster.vagrant.json -i ~/.vagrant.d/insecure_private_key -N vagrant-dbmaster
    $ knife solo cook vagrant@33.33.33.10 chef/nodes/app.vagrant.json -i ~/.vagrant.d/insecure_private_key -N vagrant-app
    $ knife solo cook vagrant@33.33.33.11 chef/nodes/balancer.vagrant.json -i ~/.vagrant.d/insecure_private_key -N vagrant-balancer

### Hacking on EC2

Add your user to the "users" databag (`chef/data_bags/users`).
  You can look at the other users for the schema.
  You can generate an encrypted password using `mkpasswd -m sha-512` or `openssl passwd -1`.

Boot EC2 instances and boostrap them:

    $ knife bootstrap -d chef-solo -x $DEPLOY_USER --sudo $SERVER

Run chef (modify these commands as you need to):

    $ knife solo cook $DEPLOY_USER@ec2-54-245-133-190.us-west-2.compute.amazonaws.com chef/nodes/dbmaster.production.json -i $DEPLOY_SSH_KEY -N dbmaster01
    $ knife solo cook $DEPLOY_USER@ec2-54-245-134-70.us-west-2.compute.amazonaws.com chef/nodes/app.production.json -i $DEPLOY_SSH_KEY -N app01
    $ knife solo cook $DEPLOY_USER@rubygems.org chef/nodes/balancer.production.json -i $DEPLOY_SSH_KEY -N balancer02

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


## License

`rubygems-aws` uses the MIT license. Please check the [LICENSE.md](LICENSE.md) file for more details.
