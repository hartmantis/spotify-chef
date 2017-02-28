require_relative '../../../spec_helper'

describe 'resource_spotify_app::debian::8_2' do
  let(:version) { nil }
  let(:dev) { nil }
  let(:action) { nil }
  let(:runner) do
    ChefSpec::SoloRunner.new(
      step_into: 'spotify_app', platform: 'debian', version: '8.2'
    )
  end
  let(:converge) { runner.converge("resource_spotify_app_test::#{action}") }

  context 'the default action (:install)' do
    let(:action) { :default }
    cached(:chef_run) { converge }

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
    let(:action) { :remove }
    cached(:chef_run) { converge }

    it 'removes the Spotify package' do
      expect(chef_run).to remove_package('spotify-client')
    end

    it 'removes the Spotify apt repo' do
      expect(chef_run).to remove_apt_repository('spotify')
    end
  end
end
