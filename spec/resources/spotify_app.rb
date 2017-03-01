# encoding: utf-8
# frozen_string_literal: true

require_relative '../resources'

shared_context 'resources::spotify_app' do
  include_context 'resources'

  let(:resource) { 'spotify_app' }
  %i(source).each { |p| let(p) { nil } }
  let(:properties) { { } }
  let(:name) { 'default' }

  shared_context 'the :install action' do
    let(:action) { nil }
  end

  shared_context 'the :remove action' do
    let(:action) { :remove }
  end

  shared_examples_for 'any platform' do
    context 'the :install action' do
      include_context description

      it 'installs a spotify_app resource' do
        expect(chef_run).to install_spotify_app(name)
      end
    end

    context 'the :remove action' do
      include_context description

      it 'removes a spotify_app resource' do
        # Windows is a special snowflake
        if platform == 'windows'
          expect { chef_run }.to raise_error(NotImplementedError)
        else
          expect(chef_run).to remove_spotify_app(name)
        end
      end
    end
  end
end
