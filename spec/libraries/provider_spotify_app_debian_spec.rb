# Encoding: UTF-8

require_relative '../spec_helper'
require_relative '../../libraries/provider_spotify_app_debian'

describe Chef::Provider::SpotifyApp::Debian do
  let(:name) { 'default' }
  let(:new_resource) { Chef::Resource::SpotifyApp.new(name, nil) }
  let(:provider) { described_class.new(new_resource, nil) }

  describe '#install!' do
    it 'configures the Spotify APT repo and installs the package' do
      p = provider
      expect(p).to receive(:add_repo)
      expect(p).to receive(:package).with('spotify-client').and_yield
      expect(p).to receive(:action).with(:install)
      p.send(:install!)
    end
  end

  describe '#remove!' do
    it 'uses a package and apt_repository to delete Spotify' do
      p = provider
      expect(p).to receive(:package).with('spotify-client').and_yield
      expect(p).to receive(:action).with(:remove)
      expect(p).to receive(:apt_repository).with('spotify').and_yield
      expect(p).to receive(:action).with(:remove)
      p.send(:remove!)
    end
  end

  describe '#add_repo' do
    it 'configures the Spotify APT repository' do
      p = provider
      expect(p).to receive(:include_recipe).with('apt')
      expect(p).to receive(:apt_repository).with('spotify').and_yield
      expect(p).to receive(:uri).with('http://repository.spotify.com')
      expect(p).to receive(:components).with(%w(stable non-free))
      expect(p).to receive(:key).with('94558F59')
      expect(p).to receive(:keyserver).with('keyserver.ubuntu.com')
      expect(p).to receive(:action).with(:add)
      p.send(:add_repo)
    end
  end
end
