require 'simplecov'
SimpleCov.start do
  add_filter '/spec/models/'
  add_filter '/spec/controllers/'

  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
end if ENV["COVERAGE"]
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
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

  Rails.application.routes.default_url_options[:host] = 'localhost:3000'
  config.include Devise::TestHelpers, :type => :controller

  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:twitter, {  :provider    => "twitter",
      :uid         => "1234",
      :user_info   => {   :name => "naim rajib",
        :nickname   => "naimrajib",
        :urls       => {  :Twitter => "www.twitter.com/naimrajib"}},
      :credentials => { :token => "lk2j3lkjasldkjflk3ljsdf"} })
    
  OmniAuth.config.add_mock(:facebook, {  :provider    => "facebook",
      :uid         => "1234",
      :user_info   => {   :name => "naim rajib",
        :nickname   => "naimrajib",
        :urls       => {  :facebook => "www.facebook.com/naimrajib"}},
      :credentials => { :token => "lk2j3lkjasldkjflk3ljsdf"} })

  OmniAuth.config.add_mock(:google_oauth2, {  :provider    => "google_oauth2",
      :uid         => "1234",
      :user_info   => {   :name => "naim rajib",
        :nickname   => "naimrajib",
        :urls       => {  :facebook => "www.facebook.com/naimrajib"}},
      :credentials => { :token => "lk2j3lkjasldkjflk3ljsdf"} })

end
