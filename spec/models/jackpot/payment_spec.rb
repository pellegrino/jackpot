require 'spec_helper'

module Jackpot 
  describe Payment , :vcr do
    it { should belong_to :customer } 
    it { should belong_to :subscription } 

    let(:subscription)      { FactoryGirl.create(:subscription, :price => 4200) } 
    let(:customer)          { FactoryGirl.create(:customer_with_valid_card, :email => 'john@doe.com') } 

    let(:invalid_customer)  { FactoryGirl.create(:customer, :email => 'john@doe.com',
                                      :credit_card_token => '-1') } 
    let(:no_card_customer)  { FactoryGirl.create(:customer, :email => 'john@doe.com') } 

    let(:payment)         { Payment.create(:description => "foo", 
                           :customer     => customer, 
                           :subscription => subscription) }

    let(:no_card_payment) { Payment.create(:description => "bar", 
                             :customer     => no_card_customer, 
                             :subscription => subscription) }


    describe "#public_fetch" , :vcr do
      before do
        @expected_payment = FactoryGirl.create(:payment, :public_token => 'abc')
        @other_payment    = FactoryGirl.create(:payment, :public_token => 'xyz')
      end 

      it "fetches a payment with the id and a public token" do
        Payment.public_fetch(@expected_payment.id, :public_token => 'abc').should == @expected_payment
      end 

      it "raises not found error when the payment does not exist" do
        expect do
          Payment.public_fetch(@expected_payment.id, :public_token => 'xyz')
        end.to raise_error ActiveRecord::RecordNotFound
      end 

    end 


    describe ".amount and .amount_in_cents" do
      it "is stored in cents but displayed in units" do
        Payment.new(:amount => 1000).amount.should == 10.0
      end 

      it "returns price in cents" do
        Payment.new(:amount => 1000).amount_in_cents.should == 1000
      end

      it { Payment.new(:amount => nil).amount.should be_nil           }  
      it { Payment.new(:amount => nil).amount_in_cents.should be_nil  } 
    end


    describe ".customer_name"  do
      it "returns its customer email" do
        payment.customer_email.should == "john@doe.com"
      end 

      it "returns blank when customer is nil" do
        payment.customer = nil
        payment.customer_email.should be_blank
      end 
    end 

    describe ".send_receipt" do
      let(:mail_mock)         { stub(:deliver => true) }

      it "uses the notifier to send a receipt" do
        Jackpot::Notifier.stub!(:send_receipt).and_return(mail_mock)
        mail_mock.should_receive(:deliver)
        payment.send_receipt
      end 
    end 

    describe "#create" do
      context "with valid token information"  do 
        let(:retrieved_payment) { Payment.find(payment.id) } 
        let(:mail_mock)         { stub(:deliver => true) }

        before do
          Jackpot::Notifier.stub!(:send_receipt).and_return(mail_mock)
        end 

        it "creates a new payment" do
          expect { payment }.to change(Payment, :count).by(1)
        end 

        it "records the payment transaction id for future reference" do
          retrieved_payment.payment_transaction_token.should_not be_nil
        end 

        it "records this payment information" do
          retrieved_payment.amount.should          == 42.0
          retrieved_payment.amount_in_cents.should == 4200
          retrieved_payment.description.should_not be_nil 
          retrieved_payment.subscription.should_not be_nil 
        end 

        it "does not persist credit card token information" do
          retrieved_payment.credit_card_token.should be_nil
        end 
        
        it "creates a random public token so it can be accessed from outside" do
          ::SecureRandom.stub!(:hex).with(16).and_return('foobar')
          retrieved_payment.public_token.should be_eql('foobar')
        end 

        it "sends a notification email" do
          mail_mock.should_receive(:deliver).and_return(true)
          retrieved_payment
        end 
      end 

      context "with no credit card token" do
        it "raises an error" do
          expect { no_card_payment }.to raise_error 
            Jackpot::Errors::CustomerHasNoCardSaved
        end 
      end 

      context "with invalid token information" , :vcr do

        it "raises an unauthorized token information" do
          expect do
            Payment.create(:description => "baz", 
                           :customer     => invalid_customer, 
                           :subscription => subscription) 
          end.to raise_error Jackpot::Errors::UnauthorizedPayment
        end

        it "must not save an additional payment" do
          begin
            Payment.create(:description => "baz", 
                           :customer     => invalid_customer, 
                           :subscription => subscription) 
            
          rescue Jackpot::Errors::UnauthorizedPayment
            Payment.count.should == 0
          end 
        end 
      end 
    end 
  end
end 
