require 'rest-client'
require 'json'

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

  class Subscription
    include Client

    def self.update(id, params)
      Client.put("subscriptions", :id => id , :subscription => params)
    end

    def self.create(params)
      Client.post("subscriptions", :subscription => params)
    end

    def self.find(id)
      JSON.parse Client.get("subscriptions/#{id}")
    end

    def self.list
      JSON.parse Client.get("subscriptions")
    end

    def self.destroy(id)
      Client.delete "subscriptions" , :id => id
    end
  end

end
