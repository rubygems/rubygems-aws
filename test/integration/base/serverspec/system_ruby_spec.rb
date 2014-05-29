require 'spec_helper'

describe 'rubygems::system_ruby' do

  describe package('ruby1.9.1-full') do
    it { should be_installed }
  end

  describe command('ruby -v') do
    it { should return_stdout(/ruby 1\.9\.3p0/) }
  end

end
