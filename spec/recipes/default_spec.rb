# encoding: utf-8
# frozen_string_literal: true

require_relative '../spec_helper'

describe 'spotify::default' do
  let(:runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { runner.converge(described_recipe) }

  it 'installs the Spotify app' do
    expect(chef_run).to install_spotify_app('default')
  end
end
