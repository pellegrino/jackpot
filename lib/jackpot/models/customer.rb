require 'dm-core'
require 'dm-serializer'


class Customer
  include DataMapper::Resource

  attr_accessor :credit_card

  property :id         ,  Serial
  property :first_name ,  String
  property :last_name  ,  String
  property :email      ,  String

  belongs_to :subscription



  def credit_card=(params)
    @credit_card = ActiveMerchant::Billing::CreditCard.new(
       :first_name         => @first_name,
       :last_name          => @last_name,
       :number             => params[:number],
       :month              => params[:month],
       :year               => params[:year],
       :verification_value => params[:verification_value])
  end
end

