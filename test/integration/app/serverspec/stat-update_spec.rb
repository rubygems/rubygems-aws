require 'spec_helper'

describe 'rubygems::stat-update' do

  describe package('stat-update') do
    it { should be_installed }
  end

end
