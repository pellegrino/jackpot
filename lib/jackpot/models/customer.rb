require 'dm-core'
require 'dm-serializer'


class Customer
  include DataMapper::Resource

  property :id         ,  Serial
  property :first_name ,  String
  property :last_name  ,  String
  property :email      ,  String

  belongs_to :subscription

end

