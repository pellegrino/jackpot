require 'rest-client'
require 'json'

module Jackpot

  class Customer

    def self.list
      JSON.parse  Jackpot::Client.get("customers")
    end

    def self.create(params)
      Jackpot::Client.post("customers", :customer => params)
    end
  end
end
