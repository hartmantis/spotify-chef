# Encoding: UTF-8

require_relative '../spec_helper'

describe 'spotify::app' do
  describe file('/Applications/Spotify.app'), if: os[:family] == 'darwin' do
    it 'exists' do
      expect(subject).to be_directory
    end
  end

  describe package('Spotify'), if: os[:family] == 'windows' do
    it 'is installed' do
      expect(subject).to be_installed
    end
  end

  describe file(File.expand_path('~/AppData/Roaming/Spotify')),
           if: os[:family] == 'windows' do
    it 'exists' do
      expect(subject).to be_directory
    end
  end
end
