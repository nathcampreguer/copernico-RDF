# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|

  config.before(:each) do
    support_path = 'spec/support/fixtures/'
    url = 'http://boldo.caiena.net:8080/geonetwork/srv/eng/'

    canned_request = File.read "#{support_path}request_all_metadata.xml"
    id_15_request  = File.read "#{support_path}id_15_request.xml"
    id_16_request  = File.read "#{support_path}id_16_request.xml"
    id_18_request  = File.read "#{support_path}id_18_request.xml"
    id_20_request  = File.read "#{support_path}id_20_request.xml"

    canned_response = File.read "#{support_path}all_metadata_results.xml"
    id_15_response  = File.read "#{support_path}id_15_response.xml"
    id_16_response  = File.read "#{support_path}id_16_response.xml"
    id_18_response  = File.read "#{support_path}id_18_response.xml"
    id_20_response  = File.read "#{support_path}id_20_response.xml"

    stub_request(:post, "#{url}xml.search")
    .with(body: canned_request, header:'application/xml')
    .to_return(body: canned_response)

    XML_MAP = {id_15_request => id_15_response,
               id_16_request => id_16_response,
               id_18_request => id_18_response,
               id_20_request => id_20_response}

    XML_MAP.each do |xml_request, xml_response|
      stub_request(:post, "#{url}xml.metadata.get")
      .with(body: xml_request, header:'application/xml')
      .to_return(body: xml_response)
    end
  end

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures

  # config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Enabling FactoryGirl methods with ease
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
end
