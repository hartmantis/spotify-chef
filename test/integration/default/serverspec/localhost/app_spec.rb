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

  describe file('/etc/apt/sources.list.d/spotify.list'),
           if: %w(ubuntu debian).include?(os[:family]) do
    it 'exists' do
      expect(subject).to be_file
    end
  end

  describe file('/usr/bin/spotify'),
           if: %w(ubuntu debian).include?(os[:family]) do
    it 'exists and is executable' do
      expect(subject).to be_executable
    end
  end
end
