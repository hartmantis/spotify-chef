require_relative '../../../spec_helper'

describe 'resource_spotify_app::mac_os_x::10_11_1' do
  let(:version) { nil }
  let(:dev) { nil }
  let(:action) { nil }
  let(:runner) do
    ChefSpec::SoloRunner.new(
      step_into: 'spotify_app', platform: 'mac_os_x', version: '10.11.1'
    )
  end
  let(:converge) { runner.converge("resource_spotify_app_test::#{action}") }

  context 'the default action (:install)' do
    let(:action) { :default }
    cached(:chef_run) { converge }

    it 'installs the Spotify package' do
      expect(chef_run).to install_dmg_package('Spotify')
        .with(source: 'http://download.spotify.com/Spotify.dmg')
    end
  end

  context 'the :remove action' do
    let(:action) { :remove }
    cached(:chef_run) { converge }

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
