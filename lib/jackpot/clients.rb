require_relative 'clients/subscription'
require_relative 'clients/customer'

module Jackpot

  module Client
    include RestClient
    JACKPOT_URL = "http://localhost:4567"

    def self.get(resource, params={:accept => :json, :content_type => :json })
      RestClient.get("#{JACKPOT_URL}/#{resource}", params)
    end

    def self.post(resource, params)
      RestClient.post("#{JACKPOT_URL}/#{resource}", params)
    end

    def self.put(resource, params)
      RestClient.put("#{JACKPOT_URL}/#{resource}", params)
    end

    def self.delete(resource, params)
      RestClient.delete("#{JACKPOT_URL}/#{resource}", params)
    end
  end
end
