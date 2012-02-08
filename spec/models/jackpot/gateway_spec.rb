require 'spec_helper'

describe Jackpot::Gateway do 

  subject { Jackpot::Gateway.new(ActiveMerchant::Billing::BogusGateway.new) } 

  describe ".store" do

    it "should delegate this call to ActiveMerchant's store method" do
      card_stub = stub(:adapted_card => 'stub')
      ActiveMerchant::Billing::BogusGateway.any_instance
                                            .should_receive(:store).with('stub')
      subject.store(card_stub)
    end 
  end

  describe ".authorize" do

    it "delegates to AM gateway" do
      card_stub = stub(:adapted_card => 'stub')
      ActiveMerchant::Billing::BogusGateway.any_instance
                                            .should_receive(:authorize).with(10, 'stub')  
      subject.authorize(10, card_stub)
    end 
  end 


  describe ".capture" do

    it "delegates to AM gateway" do
      ActiveMerchant::Billing::BogusGateway.any_instance
                                            .should_receive(:capture).with(10, 'stub')  
      subject.capture(10, 'stub')
    end 
  end 
end 
