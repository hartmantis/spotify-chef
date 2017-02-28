# Encoding: UTF-8

name 'spotify'
maintainer 'Jonathan Hartman'
maintainer_email 'j@p4nt5.com'
license 'apache2'
description 'Installs Spotify'
long_description 'Installs Spotify'
version '1.0.1'
chef_version '>= 12.9'

source_url 'https://github.com/roboticcheese/spotify-chef'
issues_url 'https://github.com/roboticcheese/spotify-chef/issues'

depends 'dmg', '~> 2.2'
depends 'windows', '~> 1.37'

supports 'mac_os_x'
supports 'windows'
supports 'ubuntu'
supports 'debian'
