# Rubygems AWS Infrastructure Configuration

Chef cookbook and bootstrap scripts to configure and manage Rubygems.org AWS infrastructure

**Note: This cookbook requires Ruby 1.9.x.**

## Hacking

    $ bundle install
    $ librarian-chef install
    $ vagrant up

## AMI's

All AMI's use instance root storage and are 64 bit.

"ap-northeast-1": "ami-be3283bf"
"ap-southeast-1": "ami-6a6f2838"
"eu-west-1": "ami-fbc6fe8f"
"sa-east-1": "ami-50b56b4d"
"us-east-1": "ami-8fac75e6"
"us-west-1": "ami-a1c59de4"
"us-west-2": "ami-f6ec60c6"

