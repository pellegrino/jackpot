require 'rest-client'

module Jackpot

  module Client
    include RestClient
    JACKPOT_URL = "http://localhost:4567"

    def self.get(resource, params={:accept => :json, :content_type => :json })
      RestClient.get("#{JACKPOT_URL}/#{resource}", params)
    end

    def self.post(resource, params)
      RestClient.post("#{JACKPOT_URL}/#{resource}", :subscription => params)
    end

  end

  class Subscription
    include Client

    def self.create(params)
      Client.post("subscriptions", params)
    end

    def self.list
      JSON.parse Client.get("subscriptions")
    end
  end

end
