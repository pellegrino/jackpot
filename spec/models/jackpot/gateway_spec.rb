require 'spec_helper'

describe Jackpot::Gateway do 

  let(:gateway_component) { ActiveMerchant::Billing::BogusGateway.new } 
  subject                 { Jackpot::Gateway.new(gateway_component) } 

  it "checks if the gateway component has a method" do
    gateway_component.should_receive(:respond_to?).with('purchase')
    subject.respond_to? 'purchase'
  end 

  it "should not recognize methods this component doesn't respond to" do
    expect { subject.foo }.to raise_error(NoMethodError)
  end 

  it "forwards every call the component knows to gateway component" do
    gateway_component.should_receive(:purchase).with(1000, 'args')
    subject.purchase(1000, 'args')
  end 

end 
