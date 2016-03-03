# Encoding: UTF-8
#
# Cookbook Name:: spotify
# Library:: resource_spotify_app_windows
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

require_relative 'resource_spotify_app'

class Chef
  class Resource
    # A Windows implementation of the spotify_app resource.
    #
    # @author Jonathan Hartman <j@p4nt5.com>
    class SpotifyAppWindows < SpotifyApp
      URL ||= 'http://download.spotify.com/Spotify.exe'.freeze
      PATH ||= ::File.expand_path('~/AppData/Roaming/Spotify').freeze

      provides :spotify_app, platform_family: 'windows'

      #
      # Use a windows_package resource to install Spotify.
      #
      action :install do
        windows_package 'Spotify' do
          source URL
          installer_type :nsis
        end
      end
    end
  end
end
