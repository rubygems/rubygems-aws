# Rubygems AWS Infrastructure Configuration

[![Build Status](https://travis-ci.org/rubygems/rubygems-aws.png?branch=master)](https://travis-ci.org/rubygems/rubygems-aws)

Chef cookbooks and bootstrap scripts to configure and manage Rubygems.org AWS infrastructure

**Note: This repository requires Ruby 1.9.x.**

## User Accounts

Chef will create all the users from the data bag "users" (`chef/data_bags/users`). To add a new user, simply add a json file to that directory with the following schema:

```json
{
    "id":"johnsmith",
    "username": "johnsmith",
    "comment":  "John Smith",
    "password": "$1$YqNay.kf$Hpl4FGvK8JkLddHOjNvPj.",
    "admin" : true,
    "ssh_keys": [
        "ssh-rsa xxxxxxxxxxxxxxxxxxx johnsmith@example.com"
    ]
}
```

You can generate an encrypted password using `mkpasswd -m sha-512` or `openssl passwd -1`.

If you want your user added to the RubyGems.org production servers, complete these steps and send a pull request.

## Hacking

    $ bundle install

### Hacking in Vagrant

We use vagrant for local development and testing of the infrastructure. You will need [Vagrant installed](http://docs.vagrantup.com/v2/installation/) and the following vagrant plugins installed:

* [vagrant-berkshelf](https://github.com/berkshelf/vagrant-berkshelf)
* [vagrant-omnibus](https://github.com/schisamo/vagrant-omnibus)

To see a list of the VMs and their status, run `vagrant status`.

To start and provision a VM, run: `vagrant up <name>`.

### Hacking on EC2

Boot EC2 instances and boostrap them:

    $ knife bootstrap -d chef-solo -x $DEPLOY_USER --sudo $SERVER

Run chef (modify these commands as you need to):

    $ knife solo cook dbmaster02-aws.rubygems.org chef/nodes/dbmaster02.json -N dbmaster02
    $ knife solo cook app01-aws.rubygems.org chef/nodes/app01.json -N app01
    $ knife solo cook balancer02-aws.rubygems.org chef/nodes/balancer02.json -N balancer02

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
