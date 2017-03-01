# encoding: utf-8
# frozen_string_literal: true

require_relative '../spec_helper'

describe 'spotify::default::app' do
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

  describe package('spotify-client'),
           if: %w(ubuntu debian).include?(os[:family]) do
    it 'is installed' do
      expect(subject).to be_installed
    end
  end
end
