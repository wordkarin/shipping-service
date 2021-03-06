require 'simplecov'
SimpleCov.start do
  'rails'
  add_filter "/helpers"
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'

require 'vcr'
require 'webmock/minitest'

VCR.configure do |config|
  config.cassette_library_dir = 'test/cassettes' # folder where casettes will be located
  config.hook_into :webmock # tie into this other tool called webmock
  config.default_cassette_options = {
    :record => :new_episodes,    # record new data when we don't have it yet
    :match_requests_on => [:method, :uri, :body] # The http method, URI and body of a request all need to match
  }
  # Don't leave our tokens lying around in a cassette file.
  #USPS
  config.filter_sensitive_data("<ACTIVESHIPPING_USPS_LOGIN>") do
    ENV['ACTIVESHIPPING_USPS_LOGIN']
  end

  #UPS
  config.filter_sensitive_data("<ACTIVESHIPPING_UPS_LOGIN>") do
    ENV['ACTIVESHIPPING_UPS_LOGIN']
  end
  config.filter_sensitive_data("<ACTIVESHIPPING_UPS_KEY>") do
    ENV['ACTIVESHIPPING_UPS_KEY']
  end
  config.filter_sensitive_data("<ACTIVESHIPPING_UPS_PASSWORD>") do
    ENV['ACTIVESHIPPING_UPS_PASSWORD']
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  Minitest::Reporters.use!

end
