require "spec_helper"

describe Jackpot::Notifier , :vcr do

  let(:payment) { FactoryGirl.create :payment             }
  let(:mail)    { Jackpot::Notifier.send_receipt(payment) }

  describe "send_receipt" do
    it "sends the receipt to the customer"  do
      mail.to.should == [payment.customer.email]
    end

    it { mail.subject.should == 'Payment receipt' }

    it "uses the configured default from" do 
      Jackpot.configuration.mailer[:from] = 'foo@example.com'
      mail.from.should == ['foo@example.com'] 
    end 

    it "sends the receipt link at the body" do
      mail.body.encoded.should match(public_receipt_payment_url(:payment_id => payment.id, :public_token => payment.public_token))
    end 


  end 
end
