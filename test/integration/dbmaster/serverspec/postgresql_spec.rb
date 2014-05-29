require 'spec_helper'

describe 'postgresql' do

  describe package('postgresql-9.2') do
    it { should be_installed }
  end

  describe command('psql --version') do
    it { should return_stdout(/9.2.8/) }
  end

  describe service('postgresql') do
    it { should be_enabled }
    it { should be_running }
  end

end
