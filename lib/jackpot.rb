require "jackpot/engine"
require 'jackpot/errors'
require 'jackpot/configuration'
require 'jackpot/factory'
require 'jackpot/cron'

require 'devise'

module Jackpot
  extend self

  def configure(&block)
    Jackpot::Payment.gateway = configuration.configure &block
  end 

  def configuration
    @configuration ||= Configuration.new
  end 

end
