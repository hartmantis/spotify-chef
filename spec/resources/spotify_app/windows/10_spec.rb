require_relative '../../../spec_helper'

describe 'resource_spotify_app::windows::10' do
  let(:version) { nil }
  let(:dev) { nil }
  let(:action) { nil }
  let(:runner) do
    ChefSpec::SoloRunner.new(
      step_into: 'spotify_app', platform: 'windows', version: '10'
    )
  end
  let(:converge) { runner.converge("resource_spotify_app_test::#{action}") }

  context 'the default action (:install)' do
    let(:action) { :default }
    cached(:chef_run) { converge }

    it 'installs the Spotify package' do
      expect(chef_run).to install_windows_package('Spotify')
        .with(source: 'http://download.spotify.com/Spotify.exe',
              installer_type: :nsis)
    end
  end
end
