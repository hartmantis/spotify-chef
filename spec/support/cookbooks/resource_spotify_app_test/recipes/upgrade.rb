# encoding: utf-8
# frozen_string_literal: true

clamav_app 'default' do
  version node['clamav']['version']
  dev node['clamav']['dev']
  action :upgrade
end
