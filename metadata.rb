# Encoding: UTF-8
#
# rubocop:disable SingleSpaceBeforeFirstArg
name             'spotify'
maintainer       'Jonathan Hartman'
maintainer_email 'j@p4nt5.com'
license          'apache2'
description      'Installs Spotify'
long_description 'Installs Spotify'
version          '0.1.1'

depends          'dmg', '~> 2.2'
depends          'windows', '~> 1.37'
depends          'apt', '~> 3.0'

supports         'mac_os_x'
supports         'windows'
supports         'ubuntu'
supports         'debian'
# rubocop:enable SingleSpaceBeforeFirstArg
