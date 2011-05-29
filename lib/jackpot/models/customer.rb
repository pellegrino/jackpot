require 'dm-core'
require 'dm-serializer'
require 'dm-transactions'

module Jackpot
  module Models

    class Customer
      include DataMapper::Resource

      attr_accessor :credit_card

      property :id                         , Serial
      property :first_name                 , String
      property :last_name                  , String
      property :email                      , String

      belongs_to :subscription , :required => false

      def credit_card=(params)
        @credit_card = ActiveMerchant::Billing::CreditCard.new(
                                                               :first_name         => @first_name,
                                                               :last_name          => @last_name,
                                                               :number             => params[:number],
                                                               :month              => params[:month],
                                                               :year               => params[:year],
                                                               :verification_value => params[:verification_value])
      end

      # Subscribes to a subscription and setup a recurring payment on
      # this.
      def subscribe(subscription)
        Customer.transaction do
          update(:subscription =>  subscription)
          response = setup_recurring_payment
        end
      end

      # Unsubscribes to current subscription
      def unsubscribe
        Customer.transaction do
          update(:subscription => nil)
        end
      end



      private
      def setup_recurring_payment
        Jackpot::Payment.recurring(subscription.price, self, subscription.recurring_options)

      end

      def cancel_recurring_payment
        Jackpot::Payment.recurring(subscription.price, self, subscription.recurring_options)
      end
    end
  end
end
