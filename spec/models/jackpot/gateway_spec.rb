require 'spec_helper'

describe Jackpot::Gateway do 

  let(:gateway_component) { ActiveMerchant::Billing::BogusGateway.new } 
  subject                 { Jackpot::Gateway.new(gateway_component) } 


  it "delegates to the gateway authorization method" do
    gateway_component.should_receive(:authorize).with(100, 123)
    subject.authorize 100, 123
  end 

  it "delegates to gateway store method" do
    gateway_component.should_receive(:store).with(credit_card)
    subject.store credit_card 
  end 

  it "delegates to gateway capture method" do
    gateway_component.should_receive(:capture).with(100, 123, 456)
    subject.capture 100, 123 , 456
  end 


  describe ".process_payment" , :vcr do

    let(:customer) { FactoryGirl.create(:customer_with_valid_card) }

    it "raises error when the card is nil" do
      expect { subject.process_payment(nil, 10) }.to raise_error(Jackpot::Errors::CustomerHasNoCardSaved)
    end 

    it "raises error when not authorized" do
      expect { subject.process_payment('456', 10) }.to raise_error(Jackpot::Errors::UnauthorizedPayment)
    end

    context "when authorized" do
      it "returns the authorization code" do
        subject.process_payment(customer.credit_card_token, 
                                            5000).should_not be_nil
      end 
    end 
  end 

end 
