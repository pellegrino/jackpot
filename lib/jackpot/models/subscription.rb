require 'ohm'

class Subscription < Ohm::Model
  attribute :name
  attribute :price

  index :name
end
