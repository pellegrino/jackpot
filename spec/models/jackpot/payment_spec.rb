require 'spec_helper'

module Jackpot 
  describe Payment do
    it { should belong_to :customer } 
    it { should belong_to :subscription } 

    let(:subscription)      { Factory(:subscription, :price => 4200) } 
    let(:customer)          { Factory(:customer, :email => 'john@doe.com',
                                      :credit_card_token => credit_card_token) } 
    let(:credit_card_token) { "977656792" } 

    let(:payment)   { Payment.create(:description => "foo", 
                       :customer     => customer, 
                       :subscription => subscription) }

    describe ".customer_name" , :vcr => { :cassette_name => "jackpot/payments_create" } do
      it "returns its customer email" do
        payment.customer_email.should == "john@doe.com"
      end 
    end 

    describe "#create", :vcr => { :cassette_name => "jackpot/payments_create" } do
      context "with valid token information"  do 
        let(:retrieved_payment) { Payment.find(payment.id) } 

        it "creates a new payment" do
          expect { payment }.to change(Payment, :count).by(1)
        end 

        it "records the payment transaction id for future reference" do
          retrieved_payment.payment_transaction_token.should == "1561055491"
        end 

        it "records this payment information" do
          retrieved_payment.amount.should          == 4200
          retrieved_payment.description.should_not be_nil 
          retrieved_payment.subscription.should_not be_nil 
        end 

        it "does not persist credit card token information" do
          retrieved_payment.credit_card_token.should be_nil
        end 

      end 

      context "with invalid token information" do
        it "raises an unauthorized token information" 
      end 
    end 
  end
end 
