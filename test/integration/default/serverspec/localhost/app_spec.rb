# Encoding: UTF-8

require_relative '../spec_helper'

describe 'spotify::app' do
  describe file('/Applications/Spotify.app'), if: os[:family] == 'darwin' do
    expect(subject).to be_directory
  end
end
