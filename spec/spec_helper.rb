# coding: utf-8
# frozen_string_literal: true


require 'rspec'
require 'stealth'
require 'mock_redis'
require 'sidekiq/testing'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'bot'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'config'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
require_relative "../bot/helpers/bot_helper"

ENV['STEALTH_ENV'] = 'test'

RSpec.configure do |config|
  I18n.load_path += Dir[File.join(File.dirname(__FILE__), '..', 'config', 'locales', '*.{rb,yml}')]
  config.include BotHelper
  config.before(:each) do |example|
    Sidekiq::Worker.clear_all
    Sidekiq::Testing.fake!
    $redis = MockRedis.new
    allow(Redis).to receive(:new).and_return($redis)
  end
  config.filter_run_when_matching :focus
  config.formatter = :documentation

  config.before(:suite) do
    Stealth.boot
  end
end
