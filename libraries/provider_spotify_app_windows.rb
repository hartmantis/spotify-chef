# Encoding: UTF-8
#
# Cookbook Name:: spotify
# Library:: provider_spotify_app_windows
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
require_relative 'provider_spotify_app'

class Chef
  class Provider
    class SpotifyApp < Provider::LWRPBase
      # An provider for Spotify on Mac OS X.
      #
      # @author Jonathan Hartman <j@p4nt5.com>
      class Windows < SpotifyApp
        URL ||= 'http://download.spotify.com/Spotify.exe'.freeze
        PATH ||= ::File.expand_path('~/AppData/Roaming/Spotify').freeze

        provides :spotify_app, platform_family: 'windows'

        private

        #
        # Download and then install the Spotify .exe package
        #
        # (see SpotifyApp#install!)
        #
        def install!
          download_package
          install_package
        end

        #
        # Use a windows_package resource to install the .exe file.
        #
        def install_package
          s = download_path
          windows_package 'Spotify' do
            source s
            installer_type :nsis
            action :install
          end
        end

        #
        # Use a remote_file resource to download the .exe file.
        #
        def download_package
          remote_file download_path do
            source URL
            action :create
            only_if { !::File.exist?(PATH) }
          end
        end

        #
        # Construct a download destination under Chef's cache dir.
        #
        # @return [String]
        #
        def download_path
          ::File.join(Chef::Config[:file_cache_path], ::File.basename(URL))
        end
      end
    end
  end
end
