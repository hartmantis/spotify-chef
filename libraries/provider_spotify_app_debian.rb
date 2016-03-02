# Encoding: UTF-8
#
# Cookbook Name:: spotify
# Library:: provider_spotify_app_debian
#
# Copyright 2015-2016, Jonathan Hartman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/provider/lwrp_base'
require 'chef/dsl/include_recipe'
require_relative 'provider_spotify_app'

class Chef
  class Provider
    class SpotifyApp < Provider::LWRPBase
      # An provider for Spotify on Mac OS X.
      #
      # @author Jonathan Hartman <j@p4nt5.com>
      class Debian < SpotifyApp
        include Chef::DSL::IncludeRecipe

        # No URL or PATH--everything is handled by APT

        provides :spotify_app, platform_family: 'debian'

        private

        #
        # Set up Spotify's APT repository and install their Debian package,
        # as documented at:
        #   https://www.spotify.com/us/download/previews
        #
        # (see SpotifyApp#install!)
        #
        def install!
          add_repo
          package 'xdg-utils'
          package 'spotify-client'
        end

        #
        # Remove Spotify's Debian package and delete their APT repo (should be
        # safe since it's strictly a repo for Spotify packages).
        #
        # (see SpotifyApp#remove!)
        #
        def remove!
          package 'spotify-client' do
            action :remove
          end
          apt_repository 'spotify' do
            action :remove
          end
        end

        #
        # Configure Spotify's APT repository, making sure APT's cache is
        # updated as well.
        #
        def add_repo
          include_recipe 'apt'
          apt_repository 'spotify' do
            uri 'http://repository.spotify.com'
            components %w(stable non-free)
            key 'D2C19886'
            keyserver 'keyserver.ubuntu.com'
            action :add
          end
        end
      end
    end
  end
end
