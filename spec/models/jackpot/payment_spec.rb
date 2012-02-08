require 'spec_helper'

module Jackpot 
  describe Payment do

    describe "payment create", :vcr do

      let(:payment) { Payment.create(:amount => 10000, 
                                     :description => "foo", 
                                     :credit_card => card_hash) }

      context "with valid credit card information"  do 
        let(:card_hash) { credit_card_hash } 

        let(:retrieved_payment) { Payment.find(payment.id) } 

        it "should create a new paymnent" do
          expect { payment }.to change(Payment, :count).by(1)
        end 

        it "should not record credit_card information" do
          retrieved_payment.credit_card.should be_nil 
        end 

        it "should record the transaction id for future reference" do
          retrieved_payment.token.should == "1559780337" 
        end 

        it "should record this payment information" do
          payment.amount.should          == 10000
          payment.customer_name.should   == 'John Doe'
          payment.description.should_not be_nil 
        end 
      end 

      context "with invalid credit card information" do
        let(:card_hash) { credit_card_hash('22') }  

        it { expect { payment}.to raise_error(Jackpot::Errors::CardIsInvalid) } 
      end 
    end 
  end
end 
