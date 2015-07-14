# Encoding: UTF-8
#
# Cookbook Name:: spotify
# Library:: provider_spotify_app_mac_os_x
#
# Copyright 2015 Jonathan Hartman
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
require_relative 'provider_spotify_app'

class Chef
  class Provider
    class SpotifyApp < Provider::LWRPBase
      # An provider for Spotify on Mac OS X.
      #
      # @author Jonathan Hartman <j@p4nt5.com>
      class MacOsX < SpotifyApp
        URL ||= 'http://download.spotify.com/Spotify.dmg'
        PATH ||= '/Applications/Spotify.app'

        provides :spotify_app, platform_family: 'mac_os_x'

        private

        #
        # Use a dmg_package resource to download and install the package. The
        # dmg_resource creates an inline remote_file, so this is all that's
        # needed.
        #
        # (see SpotifyApp#install!)
        #
        def install!
          dmg_package 'Spotify' do
            source URL
            action :install
          end
        end

        #
        # (see SpotifyApp#remove!)
        #
        def remove!
          [
            PATH,
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
end
