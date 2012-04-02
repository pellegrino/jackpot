require "spec_helper"

describe Jackpot::Notifier , :vcr do

  let(:payment) { FactoryGirl.create :payment             }
  let(:mail)    { Jackpot::Notifier.send_receipt(payment) }

  describe "send_receipt" do
    it "sends the receipt to the customer"  do
      mail.to.should == [payment.customer.email]
    end

    it { mail.from.should == ['dont-reply@example.com'] }
    it { mail.subject.should == 'Payment receipt' }

    it "sends the receipt link at the body" do
      mail.body.encoded.should match(public_receipt_payment_url(:payment_id => payment.id, :public_token => payment.public_token))
    end 
  end 
end
