require 'dm-core'
require 'dm-serializer'

class Subscription
  include DataMapper::Resource

  property :id,         Serial
  property :name,       String
  property :price,      Integer
  property :created_at, DateTime
  property :updated_at, DateTime
end
