# Encoding: UTF-8

include_recipe 'spotify'

spotify_app 'default' do
  action :remove
end
