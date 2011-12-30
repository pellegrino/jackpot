require 'spec_helper'

module Jackpot 
  describe Payment do

    describe "payment create" do
      before do
        Jackpot::Payment.gateway = ActiveMerchant::Billing::BogusGateway.new
      end 

      context "with valid credit card information"  do 
        let(:card_hash) do 
          { :number     => '1',
            :month      => '12',
            :year       => '2012',
            :first_name => 'John',
            :last_name  => 'Doe',
            :verification_value  => '123 ' }

        end 

        it "should create a new paymnent" do
          expect { 
            Payment.create(:amount => 10000, 
                           :credit_card => card_hash) }.to  change(Payment, :count).by(1)
        end 

        it "should not record credit_card information" do
          payment = Payment.create(:amount => 10000, :credit_card => card_hash) 
          Payment.find(payment.id).credit_card.should be_nil 
        end 

        it "should record this payment information" do
          payment = Payment.create(:amount => 10000, 
                                   :description => "foo", 
                                   :credit_card => card_hash) 

          payment.amount.should          == 10000
          payment.customer_name.should   == 'John Doe'
          payment.description.should_not be_nil 
        end 
      end 

      context "with invalid credit card information" 
    end 
  end
end 
