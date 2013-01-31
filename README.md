# Rubygems AWS Infrastructure Configuration

Chef cookbook and bootstrap scripts to configure and manage Rubygems.org AWS infrastructure

**Note: This cookbook requires Ruby 1.9.x.**

## Hacking

    $ bundle install
    $ librarian-chef install
    $ vagrant up

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
