ENV['RACK_ENV'] ||= 'development'

require_relative 'lib/jackpot/app'
Jackpot::Application.run!
