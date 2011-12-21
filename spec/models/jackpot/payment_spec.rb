require 'spec_helper'

module Jackpot 
  describe Payment do

    describe "payment create" do
      before do
        @card_hash =  { :number     => '4111111111111111',
                        :month      => '12',
                        :year       => '2012',
                        :first_name => 'John',
                        :last_name  => 'Doe',
                        :verification_value  => '123 '
        }
      end 

      it "should create a new card with the given information"  do
        ActiveMerchant::Billing::CreditCard.should_receive(:new).with(@card_hash)
        Payment.create(:credit_card => @card_hashs)
      end 
    end 
  end
end 
