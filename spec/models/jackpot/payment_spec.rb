require 'spec_helper'

module Jackpot 
  describe Payment do

    describe "payment create" do
      before do
        Jackpot::Payment.gateway = ActiveMerchant::Billing::BogusGateway.new
      end 

      let(:payment) { Payment.create(:amount => 10000, 
                                     :description => "foo", 
                                     :credit_card => card_hash) }

      context "with valid credit card information"  do 
        let(:card_hash) { credit_card_hash('1') } 

        let(:retrieved_payment) { Payment.find(payment.id) } 

        it "should create a new paymnent" do
          expect { payment }.to change(Payment, :count).by(1)
        end 

        it "should not record credit_card information" do
          retrieved_payment.credit_card.should be_nil 
        end 


        it "should record the transaction id for future reference" do
          # It sucks hard doing this so intrusive stubbing but BogusGateway doesn't seem to return 
          # transid as other gateways do
          ActiveMerchant::Billing::Response.any_instance.stub(:params).and_return({"transid" => "1337"})
          retrieved_payment.token.should == "1337" 
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
