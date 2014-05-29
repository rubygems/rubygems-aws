require 'spec_helper'

describe 'rubygems::users' do

  describe user('deploy') do
    it { should exist }
  end

  describe group('sysadmin') do
    it { should exist }
  end

  describe user('dwradcliffe') do
    it { should exist }
    it { should belong_to_group 'sysadmin' }
  end

  describe user('evan') do
    it { should exist }
    it { should belong_to_group 'sysadmin' }
  end

  describe user('samkottler') do
    it { should exist }
    it { should belong_to_group 'sysadmin' }
  end

  describe user('qrush') do
    it { should exist }
    it { should belong_to_group 'sysadmin' }
  end

end
