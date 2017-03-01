# encoding: utf-8
# frozen_string_literal: true

require_relative '../spotify_app'

shared_context 'resources::spotify_app::mac_os_x' do
  include_context 'resources::spotify_app'

  let(:platform) { 'mac_os_x' }

  shared_examples_for 'any MacOS platform' do
    it_behaves_like 'any platform'

    context 'the :install action' do
      include_context description

      it 'installs the Spotify package' do
        expect(chef_run).to install_dmg_package('Spotify')
          .with(source: 'http://download.spotify.com/Spotify.dmg')
      end
    end

    context 'the :remove action' do
      include_context description

      [
        '/Applications/Spotify.app',
        File.expand_path('~/Library/Application Support/Spotify'),
        File.expand_path('~/Library/Logs/Spotify')
      ].each do |d|
        it "deletes the '#{d}' directory" do
          expect(chef_run).to delete_directory(d).with(recursive: true)
        end
      end
    end
  end
end
