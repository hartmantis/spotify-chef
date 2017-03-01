# encoding: utf-8
# frozen_string_literal: true
#
# Cookbook Name:: spotify
# Library:: resource_spotify_app_mac_os_x
#
# Copyright 2015-2017, Jonathan Hartman
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

require_relative 'resource_spotify_app'

class Chef
  class Resource
    # An OS X implementation of the spotify_app resource.
    #
    # @author Jonathan Hartman <j@p4nt5.com>
    class SpotifyAppMacOsX < SpotifyApp
      provides :spotify_app, platform_family: 'mac_os_x'

      #
      # Use a dmg_package resource to install Spotify.
      #
      action :install do
        dmg_package 'Spotify' do
          source 'http://download.spotify.com/Spotify.dmg'
        end
      end

      #
      # Delete the Spotify app directory plus it's Application Support and log
      # directories.
      #
      action :remove do
        [
          '/Applications/Spotify.app',
          ::File.expand_path('~/Library/Application Support/Spotify'),
          ::File.expand_path('~/Library/Logs/Spotify')
        ].each do |d|
          directory d do
            recursive true
            action :delete
          end
        end
      end
    end
  end
end
