require 'rest-client'

module Jackpot

  module Client
    include RestClient
    JACKPOT_URL = "http://localhost:4567"

    def self.get(url, params={:accept => :json, :content_type => :json })
      super("#{JACKPOT_URL}/#{url}", params)
    end
  end

  class Subscription
    include Client

    def self.list
      JSON.parse Client.get("subscriptions")
    end
  end

end
