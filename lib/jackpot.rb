require "jackpot/engine"
require 'jackpot/errors'
require 'jackpot/configuration'
require 'jackpot/factory'
require 'jackpot/base'

require 'devise'

module Jackpot
  extend self

  def configure(&block)
    Jackpot::Base.gateway = configuration.configure &block
  end

  def configuration
    @configuration ||= Configuration.new
  end
end
