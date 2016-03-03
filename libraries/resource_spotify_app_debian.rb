# Encoding: UTF-8
#
# Cookbook Name:: spotify
# Library:: resource_spotify_app_debian
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

require 'chef/dsl/include_recipe'
require_relative 'resource_spotify_app'

class Chef
  class Resource
    # A Ubuntu/Debian implementation of the spotify_app resource.
    #
    # @author Jonathan Hartman <j@p4nt5.com>
    class SpotifyAppDebian < SpotifyApp
      include Chef::DSL::IncludeRecipe

      provides :spotify_app, platform_family: 'debian'

      #
      # Set up Spotify's APT repository and install their Debian package,
      # as documented at:
      #   https://www.spotify.com/us/download/previews
      #
      action :install do
        include_recipe 'apt'
        apt_repository 'spotify' do
          uri 'http://repository.spotify.com'
          components %w(stable non-free)
          key 'D2C19886'
          keyserver 'keyserver.ubuntu.com'
        end
        package 'xdg-utils'
        package 'spotify-client'
      end

      #
      # Remove Spotify's Debian package and delete their APT repo (should be
      # safe since it's strictly a repo for Spotify packages).
      #
      action :remove do
        package 'spotify-client' do
          action :remove
        end
        apt_repository 'spotify' do
          action :remove
        end
      end
    end
  end
end
