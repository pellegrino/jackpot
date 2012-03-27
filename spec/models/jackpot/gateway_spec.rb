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

end 
