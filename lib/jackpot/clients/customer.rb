require 'rest-client'
require 'json'

module Jackpot

  class Customer

    def self.list
      JSON.parse  Jackpot::Client.get("customers")
    end
#     def self.update(id, params)
#       Jackpot::Client.put("subscriptions", :id => id , :subscription => params)
#     end

#     def self.create(params)
#       Jackpot::Client.post("subscriptions", :subscription => params)
#     end

#     def self.find(id)
#       JSON.parse Jackpot::Client.get("subscriptions/#{id}")
#     end

#     def self.list
#       JSON.parse Jackpot::Client.get("subscriptions")
#     end

#     def self.destroy(id)
#       Jackpot::Client.delete "subscriptions" , :id => id
#     end
  end
end
