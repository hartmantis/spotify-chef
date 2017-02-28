# encoding: utf-8
# frozen_string_literal: true

include_recipe 'spotify'

spotify_app 'default' do
  action :remove
end
