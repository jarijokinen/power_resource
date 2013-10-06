ENV['RAILS_ENV'] ||= 'test'
require 'capybara/rspec'
require 'database_cleaner'
require File.join(__dir__, 'dummy/config/environment')
require 'rspec/rails'
require 'rspec/autorun'

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.fail_fast = true
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end
