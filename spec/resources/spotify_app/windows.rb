# encoding: utf-8
# frozen_string_literal: true

require_relative '../spotify_app'

shared_context 'resources::spotify_app::windows' do
  include_context 'resources::spotify_app'

  let(:platform) { 'windows' }

  shared_examples_for 'any Windows platform' do
    it_behaves_like 'any platform'

    context 'the :install action' do
      include_context description

      it 'installs the Spotify package' do
        expect(chef_run).to install_package('Spotify')
          .with(source: 'http://download.spotify.com/Spotify.exe',
                installer_type: :nsis)
      end
    end
  end
end
