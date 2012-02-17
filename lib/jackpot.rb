require "jackpot/engine"
require 'jackpot/errors'
require 'jackpot/configuration'
require 'jackpot/factory'
require 'jackpot/cron'

require 'devise'

module Jackpot
  extend self


  def configure
    yield configuration
    ActiveMerchant::Billing::Base.mode = configuration.gateway[:mode]

    factory = Jackpot::Factory.new(configuration.gateway)
    Jackpot::Payment.gateway = factory.build 
  end 

  def configuration
    @configuration ||= Configuration.new
  end 

end
