# TODO: remove when https://github.com/fog/fog-openstack/issues/202 is fixed
# require 'coveralls'
# Coveralls.wear!

require 'minitest/autorun'
require 'vcr'
require 'fog/core'
require 'fog/huaweicloud'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/huaweicloud'
  c.hook_into :webmock
  c.debug_logger = nil # use $stderr to debug
end
