require 'spec_helper'

describe Jackpot::Factory do

  it "creates jackpot gateways" do
    factory = Jackpot::Factory.new("type"=> :braintree) 
    factory.build.should be_a(Jackpot::Gateway)
  end 

  it "raises an error upon unsupported gateways" do
    factory = Jackpot::Factory.new("type"=> :notexistinggatway) 
    expect { factory.build }.to raise_error(Jackpot::Errors::InvalidGateway)
  end 

  context "supported gateways" do
    before do
      ActiveMerchant::Billing::BraintreeGateway
                                          .stub(:new).with(:login    => 'login',
                                               :password => 'password',
                                               :mode     => 'test').and_return('braintree')

      ActiveMerchant::Billing::BogusGateway.stub(:new).and_return('bogus')
    
    end 
   let(:opts) { { :type => :braintree, :login => 'login', :password => 'password', :mode => 'test' } }

    it "supports braintree" do
      factory = Jackpot::Factory.new(opts)
      Jackpot::Gateway.should_receive(:new).with('braintree')
      factory.build
    end 

    it "supports bogus for testing" do
      factory = Jackpot::Factory.new(:type => :bogus)
      Jackpot::Gateway.should_receive(:new).with('bogus')
      factory.build
    end 
  end 

end 
