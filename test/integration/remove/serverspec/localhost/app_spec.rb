# Encoding: UTF-8

require_relative '../spec_helper'

describe 'spotify::remove::app' do
  describe file('/Applications/Spotify.app'), if: os[:family] == 'darwin' do
    it 'does not exist' do
      expect(subject).to_not exist
    end
  end

  describe package('Spotify'), if: os[:family] == 'windows' do
    it 'is not installed' do
      expect(subject).to_not be_installed
    end
  end

  describe file(File.expand_path('~/AppData/Roaming/Spotify')),
           if: os[:family] == 'windows' do
    it 'does not exist' do
      expect(subject).to_not exist
    end
  end

  describe file('/etc/apt/sources.list.d/spotify.list'),
           if: %w(ubuntu debian).include?(os[:family]) do
    it 'does not exist' do
      expect(subject).to_not exist
    end
  end

  describe package('spotify-client'),
           if: %w(ubuntu debian).include?(os[:family]) do
    it 'is not installed' do
      expect(subject).to_not be_installed
    end
  end
end
