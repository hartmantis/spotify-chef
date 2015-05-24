Spotify Cookbook
================
[![Cookbook Version](https://img.shields.io/cookbook/v/spotify.svg)][cookbook]
[![Build Status](https://img.shields.io/travis/RoboticCheese/spotify-chef.svg)][travis]
[![Code Climate](https://img.shields.io/codeclimate/github/RoboticCheese/spotify-chef.svg)][codeclimate]
[![Coverage Status](https://img.shields.io/coveralls/RoboticCheese/spotify-chef.svg)][coveralls]

[cookbook]: https://supermarket.chef.io/cookbooks/spotify
[travis]: https://travis-ci.org/RoboticCheese/spotify-chef
[codeclimate]: https://codeclimate.com/github/RoboticCheese/spotify-chef
[coveralls]: https://coveralls.io/r/RoboticCheese/spotify-chef

A Chef cookbook for Spotify.

Requirements
============

This cookbook currently supports OS X only.

Usage
=====

Either add the default recipe to your run_list, or implement the resource
directly in a recipe of your own.

Recipes
=======

***default***

Installs Spotify.

Resources
=========

***spotify_app***

Used to install or remove the Spotify app.

Syntax:

    spotify_app 'default' do
        action :install
    end

Actions:

| Action     | Description       |
|------------|-------------------|
| `:install` | Install the app   |
| `:remove`  | Uninstall the app |

Attributes:

| Attribute  | Default    | Description          |
|------------|------------|----------------------|
| action     | `:install` | Action(s) to perform |

Providers
=========

***Chef::Provider::SpotifyApp::MacOsX***

Provider for Max OS X platforms.

***Chef::Provider::SpotifyApp***

A parent provider class for all the platform-specific providers to subclass.

Contributing
============

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add tests for the new feature; ensure they pass (`rake`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

License & Authors
=================
- Author: Jonathan Hartman <j@p4nt5.com>

Copyright 2015 Jonathan Hartman

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
