# encoding: utf-8
# frozen_string_literal: true

require_relative '../spotify_app'

shared_context 'resources::spotify_app::debian' do
  include_context 'resources::spotify_app'

  let(:platform) { 'debian' }

  shared_examples_for 'any Debian platform' do
    it_behaves_like 'any platform'

    context 'the :install action' do
      include_context description

      it 'configures the Spotify apt repo' do
        expect(chef_run).to add_apt_repository('spotify')
          .with(uri: 'http://repository.spotify.com',
                components: %w(stable non-free),
                key: 'D2C19886',
                keyserver: 'keyserver.ubuntu.com')
      end

      it 'installs xdg-utils' do
        expect(chef_run).to install_package('xdg-utils')
      end

      it 'installs Spotify' do
        expect(chef_run).to install_package('spotify-client')
      end
    end

    context 'the :remove action' do
      include_context description

      it 'removes the Spotify package' do
        expect(chef_run).to remove_package('spotify-client')
      end

      it 'removes the Spotify apt repo' do
        expect(chef_run).to remove_apt_repository('spotify')
      end
    end
  end
end
